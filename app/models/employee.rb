class Employee < ActiveRecord::Base
  has_and_belongs_to_many :skills
  has_and_belongs_to_many :maintenances
  has_and_belongs_to_many :events
  
  has_one :user

  validates_presence_of :first_name, :last_name, :address, :birthdate, :gender, :salary, :date_employed
  validates_numericality_of :salary
    
  before_save :calculate_years_employed, :assign_other_employee_type, :process_file_upload

  attr_accessor :other_employee_type, :img_upload

  def calculate_years_employed
    self.years_employed = Time.now.year - date_employed.year
  end

  def assign_other_employee_type
	self.employee_type = other_employee_type unless other_employee_type.blank?
  end
  
  def process_file_upload
	if img_upload
		unless img_upload.class === "String"
  	      dest = File.open("#{RAILS_ROOT}/public/images/data/#{img_upload.original_filename}", 'wb')
		  dest.write(img_upload.read)
		  self.img_url = "/images/data/#{img_upload.original_filename}" 
		end 
	end
  end

  def complete_name
    self.first_name + " " + self.last_name
  end
 
  def age
    Time.now.year - self.birthdate.year
  end
 


end
