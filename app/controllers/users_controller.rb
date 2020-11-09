class UsersController < ApplicationController

    def index
        if params[:search]
            @search = true
            @users = User.search(params[:search])
        else
            @users = current_user.friends
        end
    end

    def show
        @user = User.find_by(id: params[:id])
        @projects = @user.projects
    end

    private 

    def user_params
        params.require(:user).permit(:search)
    end 
    
end
