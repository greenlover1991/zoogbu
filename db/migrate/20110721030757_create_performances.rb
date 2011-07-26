class CreatePerformances < ActiveRecord::Migration
  def self.up
    create_table :performances do |t|
      t.integer :event_id, :null=>false
      t.date :event_date, :null=>false
      t.time :event_start, :null=>false
      t.time :event_end, :null=>false
      t.integer :no_of_visitors, :default=>0

      t.timestamps
    end
  end

  def self.down
    drop_table :performances
  end
end
