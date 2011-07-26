class Performance < ActiveRecord::Base
  belongs_to :event
  validates_numericality_of :no_of_visitors, :only_integer=>true
end
