class ChargesController < ApplicationController
before_filter :check_for_login

def new
end

def create
  customer = Stripe::Customer.create(
    :email => 'example@stripe.com',
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => params[:charge_amt],
    :description => 'Rails Stripe customer',
    :currency    => 'usd'
  )


    if (player_signed_in?)
      user = Player.find(current_player.id)
    elsif (admin_signed_in?)
      user = Admin.find(current_admin.id)
    end
		
		user.is_paid = 1
		user.player_limit = params[:player_limit]
		user.save

		# Edge case where Admin created a pool but didn't pay.  Then a player signed up, got the
		# "pool hasn't been paid for" message and paid.  Need to mark the admin account as paid
		# to indicate the pool has been paid for.
		if (user.is_admin != 1)	
			a = get_admin
			a.is_paid = 1
			a.player_limit = params[:player_limit]
			a.save
		end

    redirect_to staticpages_signupthanks_path

	rescue Stripe::CardError => e
  	flash[:error] = e.message
  	redirect_to charges_path

end

def pay_for_increase
  customer = Stripe::Customer.create(
    :email => params[:stripeEmail],
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => params[:charge_amt],
    :description => 'Increasing player limit on pool',
    :currency    => 'usd'
  )


    if (player_signed_in?)
      user = Player.find(current_player.id)
    elsif (admin_signed_in?)
      user = Admin.find(current_admin.id)
    end

		# If a user paid for an increase, just mark it as paid and record
		# the number of players he/she increased the pool by.
    user.is_paid = 1
		if user.player_limit.blank?
    	user.player_limit = params[:player_addition]
		else
    	user.player_limit = user.player_limit + params[:player_addition].to_i
		end
    user.save

    # Increase the player_limit on the admin record for this pool.
    if (user.is_admin != 1)
      a = get_admin
      a.is_paid = 1
      a.player_limit = a.player_limit + params[:player_addition].to_i
      a.save
    end

    redirect_to charges_increase_pool_size_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path

end


def increase_pool_size
    if (player_signed_in?)
      a = get_admin
			@pool_name = current_player.pool_name
			@max_pool_size = a.player_limit
    elsif (admin_signed_in?)
			@max_pool_size = current_admin.player_limit
			@pool_name = current_admin.pool_name
    end
		@current_pool_size = get_current_pool_size @pool_name
end

	private

   def check_for_login
      redirect_to staticpages_index_path unless (player_signed_in? || admin_signed_in?)
   end

   def get_admin
      if (player_signed_in?)
        user = current_player
      elsif (admin_signed_in?)
        user = current_admin
      end

      admin = Player.where("upper(pool_name) = upper(?) and is_admin = 1", user.pool_name)
      return admin[0]
    end

   def get_current_pool_size (pool_name)
      players = Player.where("upper(pool_name) = upper(?)", pool_name)
      return players.count
    end

end
