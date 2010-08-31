class Event < ActiveRecord::Base
  include ActionView::Helpers::UrlHelper

  belongs_to :category

  scope :in_category, lambda { |category|
    { :conditions => { :categories => { :name => category } },
      :include => :category }
  }
  scope :future, :conditions => ['("events"."end" IS NOT NULL AND "events"."end" >= ?) OR "events.start" >= ?', Time.now, Time.now]
  scope :approved, :conditions => { :approved => true }

  validates_presence_of :category
  validates_presence_of :start

  def self.grouped_list
    future.approved.group_by(&:day)
  end

  def approve!
    self.approved = true
    save!
  end
  def unapprove!
    self.approved = false
    save!
  end

  def day
    start.strftime('%B %d, %Y')
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
    website ? website : event_url(self)
  end

  def to_json(options = {})
    super options.merge(:only => ['url', 'name', 'description', 'time', 'location'])
  end
end
