require 'has_calendar'

class CalendarsController < ApplicationController
  layout nil

  def show
    @category = Category.find_by_name params[:category_id]
    @events = @category.events.future.approved
  end

  def teach
    @events = @category.events.future.approved
  end
end
