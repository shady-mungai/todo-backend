class TasksController < ApplicationController

    def index
        render json: Task.all
    end

    def show
        task = Task.find(params[:id])
        if task
            render json: task
        else
            render json: {errors: "Task not found"}, status: :not_found
        end
    end

    def create
        task = Task.create(task_params)
        if task.valid?
            render json: task, status: :accepted
        else
            render json: {errors:"An error occured. Please try again"}
        end
    end

    def update
        task = Task.find(params[:id])
        if task
            task.update(task_params)
            render json: task, status: :accepted
        else
            render json: {errors:"Task not found"}, status: :not_found
        end
    end

    def destroy
        task = Task.find(params[:id])
        if task
            task.destroy
            head :no_content
        else
          render json: {errors:"An error occured. Please try again"}, status: :not_found
    end

    private
    def task_params(
        params.permit(
            :task_name, :task_description, :task_status, :user_id
        )
    )  
end
