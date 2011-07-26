class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.references :employee, :null=>false
      t.string :username, :null=>false, :limit=>16
      t.string :password, :null=>false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
