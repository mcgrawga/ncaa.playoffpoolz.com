class TeamsController < ApplicationController
	before_filter :authorize_teams_edit
	before_filter :check_for_login
	before_filter :team_params, :only => :update

  def edit
		@teams = Team.find(:all, :order => "id")
  end

  def update
		params[:teams].keys.each do |team_id|
			team = Team.find(team_id)
			team.update_attributes(params[:teams][team_id])
		end
    redirect_to :back, notice: 'Teams successfully updated.' 
  end

	private
    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      #params.require(:bracket).permit(:round2_team1, :round2_team2)
      params.require(:teams).permit!
    end

    def check_for_login
			redirect_to staticpages_index_path unless (player_signed_in? || admin_signed_in?)
    end

    def authorize_teams_edit
			if (player_signed_in?)
				redirect_to staticpages_notauthorized_path unless current_player.email.downcase == 'garthmcgraw@statgolf.com'
			elsif (admin_signed_in?)
				redirect_to staticpages_notauthorized_path unless current_admin.email.downcase == 'garthmcgraw@statgolf.com'
			else
				redirect_to staticpages_notauthorized_path
			end
    end

end
