class Habitat < ActiveRecord::Base
  belongs_to :habitat_type
  has_many :animals, :dependent=>:destroy
  has_many :maintenances, :dependent=>:destroy
  has_many :events, :dependent=>:destroy
  has_many :map_areas, :dependent=>:destroy
  belongs_to :habitat_type

  attr_accessor :new_habitat_type, :img_upload
  before_save :create_new_habitat_type, :process_file_upload

  validates_presence_of :name, :max_occupants
  validates_uniqueness_of :name
  validates_numericality_of :max_occupants
  #validates_file_format_of :img_upload, 
	#					   :in=>["gif", "jpg", "jpeg", "png", "bmp", "tif", "tiff","pcx", "tga", "svg", "ico"],
	#					   :message=>"Sorry. Invalid image file"


  
  def create_new_habitat_type
    create_habitat_type(:name=> new_habitat_type) unless new_habitat_type.blank?
  end
  
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
