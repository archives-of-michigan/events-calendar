class AddRegistrationUrlToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :registration_url, :string
  end

  def self.down
    remove_column :events, :registration_url, :string
  end
end
