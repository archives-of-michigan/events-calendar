class Event < ActiveRecord::Base
  belongs_to :category

  scope :in_category, lambda do |category|
    :conditions => { :category => { :name => category.downcase.underscore } },
    :include => :categories
  end
  scope :future, :conditions => ['"events"."end" > ?', Time.now]
  scope :approved, :conditions => { :approved => true }

  validates_presence_of :category

  def self.grouped_list
    future.approved.group_by(&:day)
  end

  def start=(val)
    self[:start] = Chronic.parse val
  end
  def end=(val)
    self[:end] = Chronic.parse val
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
end
