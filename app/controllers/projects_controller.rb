class ProjectsController < ApplicationController

    def index
        # byebug
        if params[:user_id]
            @user = User.find_by(id: params[:user_id])
        else
            @user = current_user
        end
        @projects = @user.projects
    end

    def show
        @project = Project.find_by(id: params[:id])
    end

    def new
        @project = Project.new
    end

    def create
        project = Project.new(project_params)
        if project.save
            flash[:success] = "Your project was created"
            redirect_to project_path(project)
        else
            flash[:error] = "Something went wrong! Please try again."
            redirect_to new_project_path
        end
    end

    def edit
    end

    def update
    end

    def destroy
        project = Project.find_by(id: params[:id])
        project.destroy
        redirect_to projects_path

    end

    private

    def project_params
        params.require(:project).permit(:title, :private, :status, :creator_id)
    end
    
end
