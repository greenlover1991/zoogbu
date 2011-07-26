class CreateSubscribers < ActiveRecord::Migration
  def self.up
    create_table :subscribers do |t|
      t.string :first_name, :null=>false, :limit=>40
      t.string :last_name, :null=>false, :limit=>40
      t.string :email, :null=>false
      t.string :contact_no
      t.string :status, :null=>false, :default=>"Pending", :limit=>20

      t.timestamps
    end
  end

  def self.down
    drop_table :subscribers
  end
end
