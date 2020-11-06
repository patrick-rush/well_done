class ProjectsController < ApplicationController

    def index
        @user = current_user # User.find_by(id: params[:id])
        @projects = @user.projects
    end

    def show
    end

    def new
        @project = Project.new
    end

    def create
    end

    def edit
    end

    def update
    end

    def destroy
    end
    
end
