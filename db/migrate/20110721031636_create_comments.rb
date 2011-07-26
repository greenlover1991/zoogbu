class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :body, :null=>false
      t.references :post, :null=>false
      t.string :status, :limit=>20, :null=>false, :default=>"Active"
      t.string :author, :limit=>40, :null=>false

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
