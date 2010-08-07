class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.text :description
      t.boolean :all_day
      t.datetime :start
      t.datetime :end
      t.text :location
      t.string :phone
      t.string :email
      t.float :cost
      t.boolean :approved

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
