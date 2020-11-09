class ProjectsController < ApplicationController
    before_action :set_project, only: [:show, :edit, :update, :destroy]


    def index
        if params[:user_id]
            @user = User.find_by(id: params[:user_id])
        else
            @user = current_user
        end
        @projects = @user.projects
    end

    def show
    end

    def new
        @project = Project.new
    end

    def create
        @project = Project.new(project_params)
        if @project.save
            flash[:success] = "Your project was created."
            redirect_to project_path(@project)
        else
            flash[:error] = "Something went wrong! Please try again."
            redirect_to new_project_path
        end
    end

    def edit
    end

    def update
        if @project.update(project_params)
            flash[:success] = "Your project has been updated."
            redirect_to project_path(@project)
        else
            flash[:error] = "Something went wrong! Please try again."
            redirect_to edit_project_path(@project)
        end
    end

    def destroy
        @project.destroy
        redirect_to projects_path
    end

    private

    def set_project
        @project = Project.find_by(id: params[:id])
    end

    def project_params
        params.require(:project).permit(:title, :private, :status, :creator_id)
    end
    
end
