class BracketsController < ApplicationController
	before_filter :authorize_master_bracket, :only => [:edit_master, :update_master]
	before_filter :check_for_login
	before_filter :pool_paid_up

  def edit
		@master_bracket = Bracket.find_by_id(0)
		return redirect_to staticpages_nopairings_path unless @master_bracket.present?

		if (player_signed_in?)
			user_id = current_player.id
		elsif (admin_signed_in?)
			user_id = current_admin.id
		end

		if (past_cutoffdate?)
			redirect_to brackets_view_path(user_id)
		end

		@bracket = Bracket.find_by_user_id(user_id)

		if @bracket.blank?
			@bracket = duplicate_master_bracket @master_bracket
			@bracket.user_id = user_id
			@bracket.save
		end

		@bracket_points = calc_points(@bracket, @master_bracket)
		@potential_points = calc_potential_points(@bracket, @master_bracket)
		@bracket_col2_points = calc_points_column(@bracket, @master_bracket, 2)
		@bracket_col3_points = calc_points_column(@bracket, @master_bracket, 3)
		@bracket_col4_points = calc_points_column(@bracket, @master_bracket, 4)
		@bracket_col5_points = calc_points_column(@bracket, @master_bracket, 5)
		@bracket_col6_points = calc_points_column(@bracket, @master_bracket, 6)
		@bracket_col7_points = calc_points_column(@bracket, @master_bracket, 7)
		@bracket_col8_points = calc_points_column(@bracket, @master_bracket, 8)
		@bracket_col9_points = calc_points_column(@bracket, @master_bracket, 9)
		@bracket_col10_points = calc_points_column(@bracket, @master_bracket, 10)
		@bracket_col11_points = calc_points_column(@bracket, @master_bracket, 11)
		@bracket_col12_points = calc_points_column(@bracket, @master_bracket, 12)
		@cutoffdate = CutoffDate.first
  end

  def edit_master
		@master_bracket = Bracket.find_by_id(0)
		return redirect_to staticpages_nopairings_path unless @master_bracket.present?
		@bracket = Bracket.find(0)
  end

  def update
		if (!past_cutoffdate?) 
						@bracket = Bracket.find(params[:id])
						if @bracket.update(bracket_params)
							redirect_to :back, notice: 'Bracket was successfully updated.' 
						else
							render action: 'edit'
						end
		else
						redirect_to :back, notice: 'No bracket updates allowed... Past cutoff date.' 
		end
  end

  def update_master
		@bracket = Bracket.find(params[:bracket][:id])
		if @bracket.update(bracket_params)
			redirect_to :back, notice: 'Bracket was successfully updated.' 
		else
			render action: 'edit_master'
		end
  end

  def view
		@master_bracket = Bracket.find(0)
		user_id = params[:user_id]
		if user_in_same_pool(user_id)
			@bracket = Bracket.find_by_user_id(user_id)
			@bracket_points = calc_points(@bracket, @master_bracket)
			@potential_points = calc_potential_points(@bracket, @master_bracket)
			@bracket_col2_points = calc_points_column(@bracket, @master_bracket, 2)
			@bracket_col3_points = calc_points_column(@bracket, @master_bracket, 3)
			@bracket_col4_points = calc_points_column(@bracket, @master_bracket, 4)
			@bracket_col5_points = calc_points_column(@bracket, @master_bracket, 5)
			@bracket_col6_points = calc_points_column(@bracket, @master_bracket, 6)
			@bracket_col7_points = calc_points_column(@bracket, @master_bracket, 7)
			@bracket_col8_points = calc_points_column(@bracket, @master_bracket, 8)
			@bracket_col9_points = calc_points_column(@bracket, @master_bracket, 9)
			@bracket_col10_points = calc_points_column(@bracket, @master_bracket, 10)
			@bracket_col11_points = calc_points_column(@bracket, @master_bracket, 11)
			@bracket_col12_points = calc_points_column(@bracket, @master_bracket, 12)
		@cutoffdate = CutoffDate.first
		else
				redirect_to staticpages_notauthorized_path
		end
  end

  def view_master
		@master_bracket = Bracket.find_by_id(0)
		return redirect_to staticpages_nopairings_path unless @master_bracket.present?
		@bracket = Bracket.find(0)
  end

	private
    # Never trust parameters from the scary internet, only allow the white list through.
    def bracket_params
      #params.require(:bracket).permit(:round2_team1, :round2_team2)
      params.require(:bracket).permit!
    end

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
	
    def check_for_login
			redirect_to staticpages_index_path unless (player_signed_in? || admin_signed_in?)
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

    def user_in_same_pool(user_id)
			if (player_signed_in?)
      	signed_in_pool = current_player.pool_name
    	elsif (admin_signed_in?)
      	signed_in_pool = current_admin.pool_name
    	end
			player_to_view = Player.find_by_id(user_id)
		
			if player_to_view.blank? || player_to_view.pool_name.upcase != signed_in_pool.upcase
				return false
			else
				return true
			end
    end

    def authorize_master_bracket
			if (player_signed_in?)
				redirect_to staticpages_notauthorized_path unless is_super_admin?(current_player.email.downcase)
			elsif (admin_signed_in?)
				redirect_to staticpages_notauthorized_path unless is_super_admin?(current_admin.email.downcase)
			else
				redirect_to staticpages_notauthorized_path
			end
    end

end
