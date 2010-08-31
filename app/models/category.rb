class Category < ActiveRecord::Base
  has_many :events

  def to_param
    name
  end
end
