class CreateZoomaps < ActiveRecord::Migration
  def self.up
    create_table :zoomaps do |t|
      t.string :name, :null=>false
      t.text :description
      t.string :img_url, :null=>false
      t.text :img_description
      t.string :status, :null=> false, :default=>"Active", :limit=>20

      t.timestamps
    end
  end

  def self.down
    drop_table :zoomaps
  end
end
