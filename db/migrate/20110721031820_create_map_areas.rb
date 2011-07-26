class CreateMapAreas < ActiveRecord::Migration
  def self.up
    create_table :map_areas do |t|
      t.string :name, :null=>false
      t.text :description
      t.integer :x1, :null=>false
      t.integer :x2, :null=>false
      t.integer :y1, :null=>false
      t.integer :y2, :null=>false
      t.references :zoomap, :null=>false
      t.references :habitat, :null=>false
      t.string :img_url

      t.timestamps
    end
  end

  def self.down
    drop_table :map_areas
  end
end
