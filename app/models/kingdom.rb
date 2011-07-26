class Kingdom < ActiveRecord::Base
  has_many :animals
  validates_uniqueness_of :name
end
