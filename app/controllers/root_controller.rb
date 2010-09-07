class RootController < ApplicationController
  include CalendarsHelper

  def teach
    @events = Event.find :all, :conditions => "categories.name NOT LIKE 'Civil war'", :include => :category
    @year = params[:year] || Time.now.year
    @month = params[:month] || Time.now.month
  end

  def teach_events_by_day
    day_start = DateTime.new params[:year].to_i, params[:month].to_i, params[:day].to_i, 0, 0, 0
    day_end = DateTime.new params[:year].to_i, params[:month].to_i, params[:day].to_i, 23, 59, 59
    @events = Event.find :all, 
      :conditions => ["categories.name NOT LIKE 'Civil war' AND ? <= end AND ? >= start AND approved = ?", 
                      day_start, day_end, true],
      :include => :category
    @date = Date.new params[:year].to_i, params[:month].to_i, params[:day].to_i
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
