require 'date'
require 'time'
require 'fileutils'

class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :by_day, :show, :new, :create]

  # GET /events
  # GET /events.xml
  def index
    respond_to do |format|
      format.html do
        load_html_events
      end
      format.xml do
        load_data_events
        render :xml => @events
      end
      format.json do
        load_data_events
        render :json => @events
      end
    end
  end

  def by_day
    day_start = DateTime.new params[:year].to_i, params[:month].to_i, params[:day].to_i, 0, 0, 0
    day_end = DateTime.new params[:year].to_i, params[:month].to_i, params[:day].to_i, 23, 59, 59
    @events = category.events.find :all, 
      :conditions => ['? <= end AND ? >= start AND approved = ?', day_start, day_end, true]
    @date = Date.new params[:year].to_i, params[:month].to_i, params[:day].to_i
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def calendar
    category
    @calendar = Event.calendar

    respond_to do |format|
      format.json { render :json => @calendar }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    load_data

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    category
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    load_data
  end

  # POST /events
  # POST /events.xml
  def create
    parse_dates
    @category = Category.find_by_name params[:category_id]
    @event = Event.new params[:event].merge(:category => @category)

    respond_to do |format|
      if @event.save
        clear_zend_cache
        format.html
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    parse_dates
    @event = Event.find(params[:id])
    @category = @event.category

    respond_to do |format|
      if @event.update_attributes(params[:event])
        clear_zend_cache
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    load_data
    @event.destroy
    clear_zend_cache

    respond_to do |format|
      format.html { redirect_to(category_events_url(category)) }
      format.xml  { head :ok }
    end
  end

  def approve
    load_data
    event.approve!
    clear_zend_cache
    redirect_to(event, :notice => 'Event was approved.')
  end
  def unapprove
    load_data
    event.unapprove!
    clear_zend_cache
    redirect_to(event, :notice => 'Event was unapproved.')
  end

private
  def parse_dates
    [:start, :end].each { |t| params[:event][t] = parse_date(params[:event][t]) } if params[:event]
  end

  def parse_date(string)
    return nil if string.blank?
    d = Chronic.parse(string)
    d ||= Time.parse string
    d
  end

  def load_html_events
    if category
      @events = category.events.future 
      @events = @events.approved unless user_signed_in?
    else
      @events = []
    end
  end

  def load_data_events
    if category
      @events = category.events.future.approved
      @events = @events.limit params[:limit] if params[:limit]
      @events = @events.group_by(&:day)
    else
      @events = Event.future.approved
      @events = @events.limit params[:limit] if params[:limit]
    end
  end

  def clear_zend_cache
    # I know this is crazy, but it's 12am and I'm doing it!
    Dir.glob('/tmp/zend_cache*').each do |cache|
      FileUtils.rm cache
    end
  end
end
