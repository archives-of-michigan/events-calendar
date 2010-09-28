class AddSubmittedByToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :submitted_by, :string
  end

  def self.down
    remove_column :events, :submitted_by, :string
  end
end
