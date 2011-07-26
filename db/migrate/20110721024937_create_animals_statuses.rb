class CreateAnimalsStatuses < ActiveRecord::Migration
  def self.up
    create_table :animals_statuses, :id=>false do |t|
      t.integer :animal_id, :null=> false
      t.integer :status_id, :null=> false

    end

  end

  def self.down
    drop_table :animals_statuses
  end
end
