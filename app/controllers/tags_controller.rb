class TagsController < ApplicationController
  before_action :set_tag, only: [ :show, :destroy ]

  def index
    render json: Tag.all, status: :ok
  end

  def show
    render json: @tag, status: :ok    
  end

  def create
    tag = Tag.new(params[:name])
    if tag.save
      render json: tag, status: :ok
    else
      render json: { errors: tag.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @tag.destroy
      head :no_content
    else
      render json: { errors: @tag.errors.full_messages }, status: :forbidden
    end
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)      
  end
end
