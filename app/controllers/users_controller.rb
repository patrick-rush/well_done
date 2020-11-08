class UsersController < ApplicationController

    def index
        # byebug
        if params[:search]
            @search = true
            @users = User.search(params[:search])
        else
            @users = current_user.friends
        end
    end

    def show
        # byebug
        @user = User.find_by(id: params[:id])
        @projects = @user.projects
    end

    # def new
    # end

    # def create
    # end

    # def edit
    # end

    # def update
    # end

    # def destroy
    # end

    private 

    def user_params
        params.require(:user).permit(:search)
    end 
    
end
