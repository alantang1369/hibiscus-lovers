class SessionController < ApplicationController
    skip_before_action :verified_user, only: [:new, :create]
  
    def new
      @user = User.new
    end
  
    def create
        @user = User.find_by(name: params[:user][:name])
        return redirect_to '/signin' unless @user.try(:authenticate, params[:user][:password])
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      
    end
  
    def destroy
      session.delete("user_id")
      redirect_to root_path
    end
end