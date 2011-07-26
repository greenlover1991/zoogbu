class CreateHabitatTypes < ActiveRecord::Migration
  def self.up
    create_table :habitat_types do |t|
      t.string :name, :limit=> 40, :null=> false
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :habitat_types
  end
end
