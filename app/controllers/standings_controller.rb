class StandingsController < ApplicationController
	before_filter :check_for_login
	before_filter :check_for_master_bracket
	before_filter :pool_paid_up

  def show
		if (player_signed_in?)
			@pool_name = current_player.pool_name
		end
		if (admin_signed_in?)
			@pool_name = current_admin.pool_name
		end
		players = Player.where "lower(pool_name) = lower(?)", @pool_name
		@standings = calc_standings players
  end


	private

  def check_for_login
    redirect_to staticpages_index_path unless (player_signed_in? || admin_signed_in?)
  end

  def check_for_master_bracket
		redirect_to staticpages_nopairings_path unless Bracket.find_by_id(0)
  end

    def pool_paid_up
      if (player_signed_in?)
        user = current_player
      elsif (admin_signed_in?)
        user = current_admin
      end

      admin = Player.where("upper(pool_name) = upper(?) and is_admin = 1", user.pool_name)
      redirect_to staticpages_notpaid_path unless (admin[0].is_paid == 1)
    end

	def calc_standings (players)
		master_bracket = Bracket.find(0)
		standings = Hash.new
		players.each do |p|
			if (p.bracket.present?)
				standings[p] = calc_points(p.bracket, master_bracket)
			end
		end
		return standings.sort_by { |k, v| v }.reverse
	end


end
