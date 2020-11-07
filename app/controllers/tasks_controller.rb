class TasksController < ApplicationController

    def index
    end

    def show
        @task = Task.find_by(id: params[:id])
    end

    def new
        @task = Task.new
        @projects = current_user.projects
    end

    def create
        task = Task.new(task_params)
        if task.save
            flash[:success] = "Task has been added"
            redirect_to project_path(task.project_id)
        else
            flash[:error] = "Something went wrong! Please try again."
            redirect_to new_task_path
        end
    end

    def edit
        @task = Task.find_by(id: params[:id])
        @projects = current_user.projects
    end

    def update
        # byebug
        task = Task.find_by(id: params[:id])
        task.update(task_params)
        if params[:task][:status] == "1"
            task.status = "completed"
            task.save
            redirect_to task_path(task)
        end
    end

    def destroy
    end

    private

    def task_params
        params.require(:task).permit(:title, :status, :due_date, :user_id, :project_id)
    end
    
end
