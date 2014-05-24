class RegistrationsController < Devise::RegistrationsController

  def create
		return redirect_to staticpages_nomoresignups_path unless !past_cutoffdate?
		if pool_over_max_player_limit
			redirect_to staticpages_overmaxplayers_path
		else
			super
		end
  end

  protected

    def past_cutoffdate?
      cutoffdate = CutoffDate.first
      if cutoffdate.blank?
        return false
      elsif cutoffdate.dt_time.blank?
        return false
      elsif Time.zone.now < cutoffdate.dt_time
        return false
      else
        return true
      end
    end


    def duplicate_master_bracket(mb)
      b = Bracket.new
      #mb = Bracket.find(0)
      (1..64).each do |i|
        col_name = 'round2_team' + i.to_s
        b[col_name] = mb.send(col_name)
      end
      return b
    end

					def pool_over_max_player_limit
						if params['player'].present?
							pool_name = params['player']['pool_name']
						else
							pool_name = params['admin']['pool_name']
						end
						admin = get_admin_for_pool pool_name
						if (admin.blank?) # this is an admin signing up, he/she hasn't picked a pool size yet.
							return false 
						else
							pool_count = get_pool_count pool_name
							if (admin.player_limit.blank?)
								# admin never paid for pool, return false and after they sign up they will be 
								# redirected to a payment page
								return false
							end
							if (pool_count >= admin.player_limit.to_i)
								return true
							else
								return false
							end
						end
					end

					def get_pool_count (pool_name)
						players = Player.where("upper(pool_name) = upper(?)", pool_name)
						return players.count
					end

					def get_admin_for_pool (pool_name)
						admin = Player.where("upper(pool_name) = upper(?) and is_admin = 1", pool_name)
						if (admin.count > 0)
							return admin[0]
						else
							return nil
						end
					end

					def after_update_path_for(resource)
						if (player_signed_in?)
							edit_player_registration_path
						else
							edit_admin_registration_path
						end
					end

					def after_sign_up_path_for(resource)
						#create a bracket for the player by copying the master bracket, if it exists.
							if (player_signed_in?)
								user_id = current_player.id
							else
								user_id = current_admin.id
							end
							mb = Bracket.find_by_id(0)
							if (mb.present?)
								b = duplicate_master_bracket(mb)
								b.user_id = user_id
								b.save
							end
						if (player_signed_in?)
							staticpages_signupthanks_path
						else
							#staticpages_signupthanks_path
							new_charge_path
						end
					end
end
