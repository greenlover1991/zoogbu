class CreateFoods < ActiveRecord::Migration
  def self.up
    create_table :foods do |t|
      t.string :name, :null => false, :limit => 40
      t.text :description
      t.integer :qty_on_hand, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :foods
  end
end
