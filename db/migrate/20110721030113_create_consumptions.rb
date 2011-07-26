class CreateConsumptions < ActiveRecord::Migration
  def self.up
    create_table :consumptions do |t|
      t.integer :food_id, :null => false
      t.integer :maintenance_id, :null => false
      t.integer :qty_used, :null => false, :default => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :consumptions
  end
end
