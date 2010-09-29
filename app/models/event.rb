class Event < ActiveRecord::Base
  include ActionController::UrlWriter

  has_many :category_events
  has_many :categories, :through => :category_events

  scope :future, :conditions => ['events.end >= ? OR events.start >= ?', Time.now, Time.now]
  scope :approved, :conditions => { :approved => true }

  validates_presence_of :categories
  validates_presence_of :start

  attr_protected :approved

  def approve!
    self.approved = true
    save!
  end
  def unapprove!
    self.approved = false
    save!
  end

  def day
    start.httpdate
  end

  def time
    if self.end
      if start.strftime('%Y%m%d') == self.end.strftime('%Y%m%d')
        "From #{start.strftime '%I:%M%p'} to #{self.end.strftime '%I:%M%p'}"
      else
        "From #{start.strftime '%B %d, %Y'} to #{self.end.strftime '%B %d, %Y'}"
      end
    elsif all_day
      'All day'
    elsif start.present?
      start.strftime '%I:%M%p'
    else
      'No time specified'
    end
  end

  def url
    website.present? ? website : "http://seekingmichigan.org/event_manager/events/#{to_param}"
  end

  def as_json(options = {})
    {:id => id, :url => url, :name => name, :description => description, :time => time, :location => location }
  end
end
