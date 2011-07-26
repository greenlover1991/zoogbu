class CreateMaintenances < ActiveRecord::Migration
  def self.up
    create_table :maintenances do |t|
      t.integer :habitat_id, :null => false
      t.date :maintenance_date
      t.time :maintenance
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :maintenances
  end
end
