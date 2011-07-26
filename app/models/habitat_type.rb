class HabitatType < ActiveRecord::Base
  has_many :habitats, :dependent=>:destroy
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
end
