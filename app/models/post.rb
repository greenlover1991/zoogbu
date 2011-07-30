class Post < ActiveRecord::Base
  include AdminMainHelper
  has_many :comments, :dependent=>:destroy
  validates_uniqueness_of :title
  validates_presence_of :title, :body, :author
	
  attr_accessor :img_upload
	
  before_save :process_file_uploader
	
end
