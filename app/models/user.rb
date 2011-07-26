class User < ActiveRecord::Base
  belongs_to :employee

  validates_presence_of :username, :password, :password_confirmation, :employee_id
  validates_uniqueness_of :username, :password
  validates_confirmation_of :password
end
