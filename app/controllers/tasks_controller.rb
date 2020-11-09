class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]


    def index
        # byebug
        @tasks = Task.by_due_date.where(user_id: current_user.id)
    end

    def show
    end

# Start here! Need to figure out how to get project id back to controller

    def new
        if params[:project_id]
            project = Project.find_by(id: params[:project_id])
            @task = project.tasks.build #Task.build(project_id: params[:project_id])
        else
            @task = Task.new
            @projects = current_user.projects
        end
    end

    def create
        # byebug
        @task = Task.new(task_params)
        if @task.save
            flash[:success] = "Task has been added"
            redirect_to project_path(@task.project_id)
        else
            flash[:error] = "Something went wrong! Please try again."
            if params[:task][:nested_route]
                redirect_to new_project_task_path(params[:task][:project_id])
            else
                redirect_to new_task_path
            end
        end
    end

    def edit
        @projects = current_user.projects
    end

    def update
        # byebug
        if @task.update(task_params)
            flash[:success] = "Task updated."
            redirect_to project_path(@task.project)
        else
            flash[:error] = "Something went wrong! Please try again."
            redirect_to edit_task_path(@task)
        end
        # if params[:task][:completed] == true
        #     task.completed = true
        #     task.save
        #     redirect_to task_path(task)
        # end
    end

    def destroy
        project = @task.project 
        @task.destroy
        redirect_to project_path(project)
    end

    private

    def set_task
        @task = Task.find_by(id: params[:id])
    end

    def task_params
        params.require(:task).permit(:title, :completed, :due_date, :user_id, :project_id)
    end
    
end
