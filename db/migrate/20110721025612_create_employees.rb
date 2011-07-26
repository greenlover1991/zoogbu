class CreateEmployees < ActiveRecord::Migration
  def self.up
    create_table :employees do |t|
      t.string :first_name, :limit=> 40, :null=> false
      t.string :middle_name
      t.string :last_name, :limit=> 40, :null=> false
      t.string :address, :null=>false
      t.date :birthdate, :null=>false
      t.string :gender, :limit=>8, :null=>false
      t.string :tel_no
      t.string :mob_no
      t.float :salary, :null=>false
      t.date :date_employed, :null=>false
      t.integer :years_employed
      t.string :img_url
      t.string :employee_type, :null=>false

      t.timestamps
    end
  end

  def self.down
    drop_table :employees
  end
end
