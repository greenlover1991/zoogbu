class CreateAnimals < ActiveRecord::Migration
  def self.up
    create_table :animals do |t|
      t.string :name, :limit=> 40, :null=> false
      t.date :birthdate
      t.string :gender, :limit=>8
      t.float :height
      t.float :weight
      t.integer :age
      t.float :value
      t.string :motto, :limit=>80
      t.string :acquisition
      t.string :img_url
      t.text :img_description
      t.references :kingdom, :null=>false
      t.references :phylum, :null=>false
      t.references :aclass, :null=>false
      t.references :aorder, :null=>false
      t.references :family, :null=>false
      t.references :genus, :null=>false
      t.references :species, :null=>false
      t.references :habitat
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :animals
  end
end
