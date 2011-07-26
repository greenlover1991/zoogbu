class Post < ActiveRecord::Base
  has_many :comments, :dependent=>:destroy
  validates_uniqueness_of :title
  validates_presence_of :title, :body, :author
	
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
