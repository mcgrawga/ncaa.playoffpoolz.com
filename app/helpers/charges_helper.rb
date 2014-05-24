module ChargesHelper

  def get_email()
		if (player_signed_in?)
      return current_player.email
    else
    	return current_admin.email  
    end
  end


end
