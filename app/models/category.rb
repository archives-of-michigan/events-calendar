class Category < ActiveRecord::Base
  has_many :events

  validates_uniqueness_of :name

  def to_param
    name
  end
end
