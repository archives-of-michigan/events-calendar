class AddCategoryData < ActiveRecord::Migration
  def self.up
    Category.create :name => 'Special Programs'
    Category.create :name => 'Classroom'
    Category.create :name => 'Workshops'
  end

  def self.down
  end
end
