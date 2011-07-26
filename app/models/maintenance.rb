class Maintenance < ActiveRecord::Base
  has_many :consumptions, :dependent=>:destroy
  has_many :foods, :through => :consumptions

  belongs_to :habitat
  has_and_belongs_to_many :employees
  
  attr_accessor :food_ids, :food_qtys

  after_save :update_foods
  

  validates_presence_of :habitat_id


  def update_foods
    unless food_ids.nil?
      self.consumptions.each do |con|
	   # if the marked checkboxes do not include the current consumptions
	   # delete the consumption, update the food qty_on_hand
	   unless food_ids.include?(con.food_id.to_s)
	      f = Foods.find(con.food_id)
	      f.update_attributes(:qty_on_hand => f.qty_on_hand+con.qty_used) 
              con.destroy
	   # else update its qty_used attribute
	   # and food qty_on_hand
           else
              f = Foods.find(con.food_id)
	      f.update_attributes(:qty_on_hand => f.qty_on_hand + (con.qty_used - food_qtys[con.food_id.to_s].to_i))
              con.update_attributes(:qty_used => food_qtys[con.food_id.to_s])
           end
           # delete existing food ids so as not to create duplicates
	   food_ids.delete(con.food_id.to_s)
      end	

      # create consumptions for the remaining food ids
      food_ids.each do |f_id|   
	   self.consumptions.create(:food_id=>f_id, :qty_used=>food_qtys[f_id]) unless f_id.blank?
           f = Foods.find(f_id)
	   f.update_attributes(:qty_on_hand => f.qty_on_hand-food_qtys[f_id].to_i)
      end
      reload

      self.food_ids = nil
      self.food_qtys = nil
	
      # update food quantities
      

    end
  end
end
