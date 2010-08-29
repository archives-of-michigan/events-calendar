require 'date'

class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :by_day, :show, :new, :create]

  # GET /events
  # GET /events.xml
  def index
    @events = Event.in_category(params[:category]).future
    @events = @events.limit params[:limit] if params[:limit]
    @events = @events.approved unless user_signed_in?

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => Event.grouped_list }
      format.json { render :json => Event.grouped_list }
    end
  end

  def by_day
    day_start = DateTime.new params[:year].to_i, params[:month].to_i, params[:day].to_i, 0, 0, 0
    day_end = DateTime.new params[:year].to_i, params[:month].to_i, params[:day].to_i, 23, 59, 59
    @events = Event.in_category(params[:category]).find :all, 
      :conditions => ['? <= end AND ? >= start AND approved = ?', day_start, day_end, true]
    @date = Date.new params[:year].to_i, params[:month].to_i, params[:day].to_i
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def calendar
    @calendar = Event.calendar

    respond_to do |format|
      format.json { render :json => @calendar }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
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
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
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
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end

  def approve
    event.approve!
    redirect_to(event, :notice => 'Event was approved.')
  end
  def unapprove
    event.unapprove!
    redirect_to(event, :notice => 'Event was unapproved.')
  end

private
  def event
    @event = Event.find(params[:id])
  end
end
