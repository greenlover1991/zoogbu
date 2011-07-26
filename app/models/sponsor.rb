class Sponsor < ActiveRecord::Base
  has_many :animals
  has_many :sponsorships
  validates_presence_of :name, :contact_no
  validates_uniqueness_of :name
end
