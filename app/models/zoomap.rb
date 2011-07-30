class Zoomap < ActiveRecord::Base
  include AdminMainHelper
  has_many :map_areas, :dependent=>:destroy
	
  validates_presence_of :name, :img_upload
  validates_uniqueness_of :name
	
  attr_accessor :img_upload

  before_save :process_file_uploader
	
end
