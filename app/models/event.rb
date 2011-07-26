class Event < ActiveRecord::Base
  belongs_to :habitat
  
  has_and_belongs_to_many :employees
  has_and_belongs_to_many :animals
  
  has_many :performances, :dependent=>:destroy
    
  validates_uniqueness_of :name
  validates_presence_of :name, :capacity, :habitat_id
  validates_numericality_of :capacity, :only_integer=>true
  	   
  before_save :process_file_upload
  attr_accessor :img_upload
  
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
