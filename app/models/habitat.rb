class Habitat < ActiveRecord::Base
  belongs_to :habitat_type
  has_many :animals, :dependent=>:destroy
  has_many :maintenances, :dependent=>:destroy
  has_many :events, :dependent=>:destroy
  has_many :map_areas, :dependent=>:destroy
  belongs_to :habitat_type

  attr_accessor :new_habitat_type
  before_save :create_new_habitat_type

  validates_presence_of :name, :max_occupants
  validates_uniqueness_of :name
  validates_numericality_of :max_occupants


  
  def create_new_habitat_type
    create_habitat_type(:name=> new_habitat_type) unless new_habitat_type.blank?
  end
  

end
