module StaticpagesHelper
   def get_admin
      if (player_signed_in?)
        user = current_player
      elsif (admin_signed_in?)
        user = current_admin
      end

      admin = Player.where("upper(pool_name) = upper(?) and is_admin = 1", user.pool_name)
			return admin[0]
    end
end
