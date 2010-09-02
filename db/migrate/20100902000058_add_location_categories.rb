class AddLocationCategories < ActiveRecord::Migration
  def self.up
    ['Fort Wilkins','Iron Industry Museum','Father Marquette Memorial','Fayette Historic Townsite','Thunder Bay National Marine Sanctuary','Hartwick Pines and CCC Museum','Tawas Point Historic Lighthouse','Sanilac Petroglyphs','Michigan Historical Museum','Walker Tavern','Mann House'].each do |category|
      Category.create! :name => category
    end
  end

  def self.down
    ['Fort Wilkins','Iron Industry Museum','Father Marquette Memorial','Fayette Historic Townsite','Thunder Bay National Marine Sanctuary','Hartwick Pines and CCC Museum','Tawas Point Historic Lighthouse','Sanilac Petroglyphs','Michigan Historical Museum','Walker Tavern','Mann House'].each do |category|
      Category.find_by_name(category).destroy
    end
  end
end
