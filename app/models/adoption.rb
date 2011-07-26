class Adoption < ActiveRecord::Base
  belongs_to :animal
  belongs_to :buyer
  
  validates_presence_of :animal_id, :buyer_id, :delivery_address, :payment_mode
  validates_uniqueness_of :animal_id
end
