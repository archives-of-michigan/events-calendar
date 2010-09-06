class CategoriesController < ApplicationController
  def index
  end

  def show
    @category = Category.find_by_name params[:id]
    @events = @category.events.future.order 'start'
    @events = @events.approved unless user_signed_in?
  end
end
