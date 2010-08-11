require 'has_calendar'

class CalendarsController < ApplicationController
  layout nil
  def show
    current_year = Date.today.year.to_i
    @years = (current_year..(current_year + 5))
    @months = { 'January' => 1, 'February' => 2, 'March' => 3, 'April' => 4, 'May' => 5, 'June' => 6, 
               'July' => 7, 'August' => 8, 'September' => 9, 'October' => 10, 'November' => 11, 'December' => 12 }
  end
end
