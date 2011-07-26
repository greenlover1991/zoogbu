class Subscriber < ActiveRecord::Base
   validates_presence_of :first_name, :last_name, :email
   validates_format_of :email, :with=>/.+@.+\..+/
   validates_uniqueness_of :email
   
   def complete_name
     self.first_name + " " + self.last_name
   end
end
