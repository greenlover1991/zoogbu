class CreateBuyers < ActiveRecord::Migration
  def self.up
    create_table :buyers do |t|
      t.string :name, :null=>false, :limit=>40
      t.string :contact_no, :null=>false
      t.string :status, :limit => 20, :default => "Pending", :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :buyers
  end
end
