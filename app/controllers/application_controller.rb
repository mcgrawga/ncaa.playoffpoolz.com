class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	before_filter :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
		if (player_signed_in?)
    	brackets_edit_path
		else
    	brackets_edit_path
		end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :pool_name
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
    devise_parameter_sanitizer.for(:sign_up) << :is_admin
    devise_parameter_sanitizer.for(:account_update) << :first_name
    devise_parameter_sanitizer.for(:account_update) << :last_name
  end

  def calc_points (pb, mb)  #player_bracket, master_bracket.  Returns current points for a players bracket.
    points = 0
    (1..32).each do |t|
      col_name = 'round3_team' + t.to_s
      points = points + 1 if pb.send(col_name) == mb.send(col_name) && mb.send(col_name) != nil
    end

    (1..16).each do |t|
      col_name = 'round4_team' + t.to_s
      points = points + 2 if pb.send(col_name) == mb.send(col_name) && mb.send(col_name) != nil
    end

    (1..8).each do |t|
      col_name = 'round5_team' + t.to_s
      points = points + 4 if pb.send(col_name) == mb.send(col_name) && mb.send(col_name) != nil
    end

    (1..4).each do |t|
      col_name = 'round6_team' + t.to_s
      points = points + 6 if pb.send(col_name) == mb.send(col_name) && mb.send(col_name) != nil
    end

    (1..2).each do |t|
      col_name = 'round7_team' + t.to_s
      points = points + 8 if pb.send(col_name) == mb.send(col_name) && mb.send(col_name) != nil
    end

    (1..1).each do |t|
      col_name = 'round8_team' + t.to_s
      points = points + 10 if pb.send(col_name) == mb.send(col_name) && mb.send(col_name) != nil
    end

    return points
  end

  private

end
