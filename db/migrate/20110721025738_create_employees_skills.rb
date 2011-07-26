class CreateEmployeesSkills < ActiveRecord::Migration
  def self.up
    create_table :employees_skills, :id=>false do |t|
      t.integer :employee_id, :null=> false
      t.integer :skill_id, :null=> false

    end
  end

  def self.down
    drop_table :employees_skills
  end
end
