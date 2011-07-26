class Food < ActiveRecord::Base
  has_many :consumptions, :dependent=>:destroy
  has_many :maintenances, :through => :consumptions

  validates_presence_of :name, :qty_on_hand
  validates_uniqueness_of :name
  validates_numericality_of :qty_on_hand, :only_integer => true

end
