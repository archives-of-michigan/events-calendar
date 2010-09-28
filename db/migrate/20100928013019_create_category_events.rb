class CreateCategoryEvents < ActiveRecord::Migration
  def self.up
    create_table :category_events do |t|
      t.integer :category_id
      t.integer :event_id

      t.timestamps
    end

    Event.all.each do |event|
      CategoryEvent.create! :event => event, :category_id => event.category_id
    end

    remove_column :events, :category_id
  end

  def self.down
    drop_table :category_events
  end
end
