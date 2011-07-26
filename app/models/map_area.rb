class MapArea < ActiveRecord::Base
  belongs_to :zoomap
  belongs_to :habitat

  validates_presence_of :name, :zoomap_id, :habitat_id, :x1, :x2, :y1, :y2
  validates_uniqueness_of :name
  validates_numericality_of :x1, :x2, :y1, :y2, :greater_than=>0

  attr_accessor :img_upload
	
  before_save :process_file_upload
	
  private 
    def process_file_upload
	if img_upload
	  unless img_upload.class === "String"
	    dest = File.open("#{RAILS_ROOT}/public/images/data/#{img_upload.original_filename}", 'wb')
	    dest.write(img_upload.read)
	    self.img_url = "/images/data/#{img_upload.original_filename}" 
	  end 
	end
    end
  
end
