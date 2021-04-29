class UsersController < ApplicationController
    skip_before_action :verified_user, only: [:new, :create]

    def new
        @user = User.new
    end

    def create
        @user = User.create(user_params) 
        if @user.valid?
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render 'new'
        end
    end

    def show 
        @user = User.find_by(id: params[:id])
    end

    def edit 
        @user = User.find_by(id: params[:id])
    end

    def update
        @user = User.find_by(id: params[:id])
        if @user.update(user_params)
            redirect_to @user
        else
            render 'edit'
        end
    end

    private 

    def user_params
        params.require(:user).permit(
            :name,
            :password,
            :wallet ,
            :address ,
            :email,
            :admin
        )
    end

end
