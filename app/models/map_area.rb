class MapArea < ActiveRecord::Base
  belongs_to :zoomap
  belongs_to :habitat

  validates_presence_of :name, :zoomap_id, :habitat_id, :x1, :x2, :y1, :y2
  validates_uniqueness_of :name
  validates_numericality_of :x1, :x2, :y1, :y2, :greater_than=>0

	
  
end
