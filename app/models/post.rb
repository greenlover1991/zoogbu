class Post < ActiveRecord::Base
  has_many :comments, :dependent=>:destroy
  validates_uniqueness_of :title
  validates_presence_of :title, :body, :author
	
end
