class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
  before_action :verified_user
  helper_method :current_user, :user_is_current_user, :admin?
  
  
  #private


  def verified_user
    redirect_to '/', alert:"Please signup or signin to continue!" unless user_is_authenticated
  end

  def user_is_authenticated
    !!current_user
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def user_is_current_user(user)
    true if user.id == current_user.id
  end

  def admin?
    current_user.admin
  end
  
end
