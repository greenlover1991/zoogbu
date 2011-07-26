class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name, :limit=>40, :null=>false
      t.text :description
      t.integer :capacity, :null=>false, :default=>1
      t.string :img_url
      t.text :img_description
      t.references :habitat, :null=>false

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
