class AddCategoryIdToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :category_id, :integer

    c = Category.create :name => 'Civil war'
    Event.all.each { |e| e.category = c; e.save }
  end

  def self.down
    remove_column :events, :category_id, :integer
  end
end
