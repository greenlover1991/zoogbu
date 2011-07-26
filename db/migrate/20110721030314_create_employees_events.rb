class CreateEmployeesEvents < ActiveRecord::Migration
  def self.up
    create_table :employees_events, :id=>false do |t|
      t.integer :employee_id, :null=> false
      t.integer :event_id, :null=> false

    end
  end

  def self.down
    drop_table :employees_events
  end
end
