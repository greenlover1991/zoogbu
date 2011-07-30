class Event < ActiveRecord::Base
  belongs_to :habitat
  
  has_and_belongs_to_many :employees
  has_and_belongs_to_many :animals
  
  has_many :performances, :dependent=>:destroy
    
  validates_uniqueness_of :name
  validates_presence_of :name, :capacity, :habitat_id
  validates_numericality_of :capacity, :only_integer=>true
  	   
  


end
