class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title, :limit=>40, :null=>false
      t.text :body, :null=>false
      t.string :status, :limit=>20, :null=>false, :default=>"Pending"
      t.string :author, :limit=>40, :null=>false
      t.string :img_url
      t.text :img_description

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
