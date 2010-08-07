class Event < ActiveRecord::Base
  scope :future, :conditions => ['"events"."end" > ?', Time.now]
  scope :approved, :conditions => { :approved => true }

  def start=(val)
    self[:start] = Chronic.parse val
  end
  def end=(val)
    self[:end] = Chronic.parse val
  end
end
