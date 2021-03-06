class SessionController < ApplicationController
    skip_before_action :verified_user, only: [:new, :create, :create_with_github]
  
    def new
      @user = User.new
    end
  
    def create
        @user = User.find_by(name: params[:user][:name])
        return redirect_to '/signin', alert: "Please check your name or password!" unless @user.try(:authenticate, params[:user][:password])
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      
    end
    
    
    def create_with_github
      
      @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.name = auth['info']['nickname']
        u.email = "none"
        u.password = "alan"
      end
   
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    end

  
    def destroy
      session.delete("user_id")
      redirect_to root_path
    end

    private 
    def auth
      request.env['omniauth.auth']
    end
end