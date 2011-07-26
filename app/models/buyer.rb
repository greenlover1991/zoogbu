class Buyer < ActiveRecord::Base
  has_many :animals
  has_many :adoptions
  validates_presence_of :name, :contact_no
  validates_uniqueness_of :name
end
