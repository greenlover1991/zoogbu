class Zoomap < ActiveRecord::Base
  has_many :map_areas, :dependent=>:destroy
	
  validates_presence_of :name, :img_url
  validates_uniqueness_of :name
end
