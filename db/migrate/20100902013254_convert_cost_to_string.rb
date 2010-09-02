class ConvertCostToString < ActiveRecord::Migration
  def self.up
    change_column :events, :cost, :string
  end

  def self.down
    change_column :events, :cost, :float
  end
end
