class CreateAnimalsEvents < ActiveRecord::Migration
  def self.up
    create_table :animals_events, :id=>false do |t|
      t.integer :animal_id, :null=> false
      t.integer :event_id, :null=> false

    end
  end

  def self.down
    drop_table :animals_events
  end
end
