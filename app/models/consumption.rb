class Consumption < ActiveRecord::Base
  belongs_to :food
  belongs_to :maintenance

  validates_presence_of :qty_used
  validates_numericality_of :qty_used, :only_integer => true

end
