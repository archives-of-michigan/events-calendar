require 'has_calendar'

class CalendarsController < ApplicationController
  layout nil
  def show
    @category = Category.find_by_name params[:category_id]
    @events = Event.future.approved.in_category params[:category_id]
    current_year = Date.today.year.to_i
    @years = (current_year..(current_year + 5)).inject([]) do |list, y|
      list << y
    end
    @months = [
      [ 'January', 1 ], 
      [ 'February', 2 ],
      [ 'March', 3 ],
      [ 'April', 4 ], 
      [ 'May', 5],
      [ 'June', 6], 
      [ 'July', 7],
      [ 'August', 8],
      [ 'September', 9],
      [ 'October', 10],
      [ 'November', 11],
      [ 'December', 12 ]
    ]
  end
end
