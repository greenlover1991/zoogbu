class Animal < ActiveRecord::Base
  belongs_to :kingdom
  belongs_to :phylum
  belongs_to :aclass
  belongs_to :aorder
  belongs_to :family
  belongs_to :genus
  belongs_to :species
  belongs_to :habitat, :counter_cache => true

  has_one :sponsorship
  has_one :adoption

  has_and_belongs_to_many :statuses
  has_and_belongs_to_many :events

  #virtual attributes
  attr_accessor :new_kingdom, :new_phylum, :new_aclass, :new_aorder, 
                :new_family, :new_genus, :new_species, :img_upload

  #validations
  validates_presence_of :name, :habitat_id
  validates_uniqueness_of :name
  validates_numericality_of :height, :weight, :value
  
  before_save :create_new_taxonomy, :calculate_age, :process_file_upload

  def create_new_taxonomy
    create_kingdom(:name=> new_kingdom) unless new_kingdom.blank? 
    create_phylum(:name=> new_phylum) unless new_phylum.blank?
    create_aclass(:name=> new_aclass) unless new_aclass.blank?
    create_aorder(:name=> new_aorder) unless new_aorder.blank?
    create_family(:name=> new_family) unless new_family.blank?
    create_genus(:name=> new_genus) unless new_genus.blank?
    create_species(:name=> new_species) unless new_species.blank?
  end

  def calculate_age
    self.age = Time.now.year - birthdate.year
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
  
  def scientific_name
	self.genus.name + " " + self.species.name
  end


end
