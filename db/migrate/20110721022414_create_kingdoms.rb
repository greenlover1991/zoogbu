class CreateKingdoms < ActiveRecord::Migration
  def self.up
    create_table :kingdoms do |t|
      t.string :name, :limit=> 40, :null=> false

      t.timestamps
    end
  end

  def self.down
    drop_table :kingdoms
  end
end
