class UsersController < ApplicationController

    def index
        if params[:search]
            @users = User.search(params[:search])
        else
            @users = current_user.friends
        end
    end

    def show
        @user = User.find_by(id: params[:id])
        if @user == current_user
            @projects = @user.projects
        elsif @user
            @projects = @user.public_projects
        else
            flash[:error] = "Something went wrong! Please try again."
            redirect_to root_path
        end
    end

    private 

    def user_params
        params.require(:user).permit(:search)
    end 
    
end
