class CutoffDateController < ApplicationController
  before_filter :authorize_cutoffdate
	
	def edit
		@cutoffdate = CutoffDate.first
   	if @cutoffdate.blank?
      @cutoffdate = CutoffDate.new
      @cutoffdate.save
    end
	end

	def update
		id = params[:cutoff_date][:id]
  	@cutoffdate = CutoffDate.find(id)
    if @cutoffdate.update(cutoffdate_params)
      redirect_to :back, notice: 'Cutoff date was successfully updated.'
    else
      render action: 'edit'
    end

	end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def cutoffdate_params
      #params.require(:bracket).permit(:round2_team1, :round2_team2)
      params.require(:cutoffdate).permit!
    end

    def authorize_cutoffdate
      if (player_signed_in?)
        redirect_to staticpages_notauthorized_path unless current_player.email.downcase == 'garthmcgraw@statgolf.com'
      elsif (admin_signed_in?)
        redirect_to staticpages_notauthorized_path unless current_admin.email.downcase == 'garthmcgraw@statgolf.com'
      else
        redirect_to staticpages_notauthorized_path
      end
    end


end
