class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      found_items = user.items
    else
      found_items = Item.all
    end
    render json: found_items, include: :user
  end

  def show
    if params[:user_id]
      item = Item.find(params[:id])
    else
      item = Item.find(params[:id])
    end
    render json: item, status: :ok
  end

  def create
    item = Item.create!(item_params)
    render json: item, include: :user, status: :created
  end

  private

  def item_params
    params.permit(:price, :description, :name, :user_id)
  end

  def render_not_found_response
    render json: { error: "Item not found" }, status: :not_found
  end

end
