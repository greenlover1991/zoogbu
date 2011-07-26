class CreateHabitats < ActiveRecord::Migration
  def self.up
    create_table :habitats do |t|
      t.string :name, :limit=> 40, :null=> false
      t.integer :animals_count, :default =>0
      t.integer :max_occupants, :null =>false
      t.string :img_url
      t.text :img_description
      t.text :description
      t.references :habitat_type, :null =>false

      t.timestamps
    end
  end

  def self.down
    drop_table :habitats
  end
end
