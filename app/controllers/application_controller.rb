class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :choose_layout

  def event
    @event = Event.find params[:id] if params[:id]
  end

  def category
    return @category if @category
    if event
      @category = event.category
    elsif params[:category_id]
      @category = Category.find_by_name params[:category_id]
    end
  end

  def load_data
    event
    category
  end

private
  def choose_layout
    if category.name == 'Civil war'
      'civil_war'
    else
      'teach'
    end
  end
end
