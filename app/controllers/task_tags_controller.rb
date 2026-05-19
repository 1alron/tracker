class TaskTagsController < ApplicationController
  def create
    task_tag = TaskTag.new(task_tag_params)

    if task_tag.save
      render json: {
          id: task_tag.id,
          task_id: task_tag.task_id,
          tag_id: task_tag.tag_id,
          message: "Tag added to task"
        }, status: :created
    else
      render json: { errors: task_tag.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    task_tag = TaskTag.find(params[:id])
    task_tag.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: "TaskTag not found" }, status: :not_found
  end

  private

  def task_tag_params
    params.require(:task_tag).permit(:task_id, :tag_id)
  end
end
