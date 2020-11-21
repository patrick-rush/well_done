class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]

    def index
        @tasks = Task.by_due_date(current_user)
    end

    def completed
        @tasks = Task.completed(current_user)
    end

    def show
        @comment = Comment.new
    end

    def new
        if params[:project_id]
            project = Project.find_by(id: params[:project_id])
            @task = project.tasks.build
        else
            @task = Task.new
            @projects = current_user.projects
        end
    end

    def create
        @task = Task.new(task_params)
        if @task.save
            flash[:success] = "Task has been added"
            redirect_to project_path(@task.project_id)
        else
            if params[:task][:nested_route]
                render :new
            else
                @task.project_id = nil
                @projects = current_user.projects 
                render :new
            end
        end
    end

    def edit
        @projects = current_user.projects
    end

    def update
        if @task.update(task_params)
            flash[:success] = "Task updated."
            redirect_to project_path(@task.project)
        else
            render :edit
        end
    end

    def destroy
        project = @task.project 
        @task.destroy
        redirect_to project_path(project)
    end

    private

    def set_task
        @task = Task.find_by(id: params[:id])
        if @task && !@task.project.users.include?(current_user) && @task.project.private
            flash[:error] = "You are not permitted to see that page!"
            redirect_to projects_path
        elsif !@task 
            flash[:error] = "No task found."
            redirect_to projects_path
        end
    end

    def task_params
        params.require(:task).permit(:title, :completed, :due_date, :user_id, :project_id)
    end
    
end
