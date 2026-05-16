class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy ]

  def index
    tasks = TasksFilterService.new(params).call
    render json: tasks, status: :ok
  end

  def show
    render json: @task, status: :ok
  end

  def create
    task = Task.new(task_params)
    if task.save
      render json: task, status: :created
    else
      render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task, status: :ok
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    head :no_content     
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :exec_date)
  end
end
