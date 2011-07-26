class CreateSpecies < ActiveRecord::Migration
  def self.up
    create_table :species do |t|
      t.string :name, :limit=> 40, :null=> false

      t.timestamps
    end
  end

  def self.down
    drop_table :species
  end
end