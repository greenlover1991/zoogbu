class Sponsorship < ActiveRecord::Base
  belongs_to :animal
  belongs_to :sponsor
  
  validates_presence_of :animal_id, :sponsor_id
  validates_uniqueness_of :animal_id
end
