class ProjectsController < ApplicationController
    before_action :set_project, only: [:show, :edit, :update, :destroy]


    def index
        if params[:user_id]
            @user = User.find_by(id: params[:user_id])
            @projects = @user.public_projects
        else
            @user = current_user
            @projects = @user.projects.uniq
        end
    end

    def show
        @comment = Comment.new
    end

    def new
        @project = Project.new
        @project.tasks.build
    end

    def create
        @project = Project.create(project_params)
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
        if @project && !@project.users.include?(current_user) && @project.private 
            flash[:error] = "You are not permitted to see that page!"
            redirect_to projects_path
        elsif !@project
            flash[:error] = "No project found."
            redirect_to projects_path
        end
    end

    def project_params
        params.require(:project).permit(
            :title,
            :private,
            tasks_attributes: [
                :user_id,
                :title,
                :due_date
            ]
        )
    end
    
end
