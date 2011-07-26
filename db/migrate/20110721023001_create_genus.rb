class CreateGenus < ActiveRecord::Migration
  def self.up
    create_table :genus do |t|
      t.string :name, :limit=> 40, :null=> false

      t.timestamps
    end
  end

  def self.down
    drop_table :genus
  end
end
