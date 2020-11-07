class TasksController < ApplicationController

    def index
    end

    def show
    end

    def new
        @task = Task.new
        @projects = current_user.projects
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
