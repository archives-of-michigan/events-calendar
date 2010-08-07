class Event < ActiveRecord::Base
  def start=(val)
    update_attributes :start => Chronic.parse(val)
  end
  def end=(val)
    update_attributes :end => Chronic.parse(val)
  end
end
