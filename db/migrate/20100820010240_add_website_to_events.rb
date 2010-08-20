class AddWebsiteToEvents < ActiveRecord::Migration
  def self.up
    add_colum :events, :website, :string
  end

  def self.down
    remove_colum :events, :website
  end
end
