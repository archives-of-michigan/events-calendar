class Category < ActiveRecord::Base
  has_many :category_events
  has_many :events, :through => :category_events

  validates_uniqueness_of :name

  def to_param
    name
  end
end
