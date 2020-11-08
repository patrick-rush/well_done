class TasksController < ApplicationController

    def index
        @tasks = Task.by_due_date.where(user_id: current_user.id)
    end

    def show
        @task = Task.find_by(id: params[:id])
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
        if task.update(task_params)
            redirect_to task_path(task)
        else
            redirect_to edit_task_path(task)
        end
        # if params[:task][:completed] == true
        #     task.completed = true
        #     task.save
        #     redirect_to task_path(task)
        # end
    end

    def destroy
        task = Task.find_by(id: params[:id])
        project = task.project 
        task.destroy
        redirect_to project_path(project)
    end

    private

    def task_params
        params.require(:task).permit(:title, :completed, :due_date, :user_id, :project_id)
    end
    
end
