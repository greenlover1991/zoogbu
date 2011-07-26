class Comment < ActiveRecord::Base
  belongs_to :post
  validates_presence_of :body, :author, :post_id
end
