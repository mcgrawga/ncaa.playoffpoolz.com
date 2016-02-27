# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Creating an global function that can be used everywhere, controllers, views, etc.
  def is_super_admin?(email) 
  	User.where('is_admin = 1').each do |user|
  		if user.email == email
  			return true
		end
	end
    return false
  end

# Initialize the Rails application.
Ncaa::Application.initialize!
