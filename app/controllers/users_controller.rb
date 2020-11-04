class UsersController < ApplicationController

    # def index
    # end

    def show
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
    
end
