class CreateEmployeesMaintenances < ActiveRecord::Migration
  def self.up
    create_table :employees_maintenances, :id=>false do |t|
      t.integer :employee_id, :null=> false
      t.integer :maintenance_id, :null=> false

    end
  end

  def self.down
    drop_table :employees_maintenances
  end
end
