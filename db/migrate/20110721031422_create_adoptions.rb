class CreateAdoptions < ActiveRecord::Migration
  def self.up
    create_table :adoptions do |t|
      t.integer :animal_id, :null=>false
      t.integer :buyer_id, :null=>false
      t.date :purchase_date, :null=>false
      t.string :delivery_address, :null=>false
      t.string :payment_mode, :null=>false

      t.timestamps
    end
  end

  def self.down
    drop_table :adoptions
  end
end
