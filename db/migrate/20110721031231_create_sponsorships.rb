class CreateSponsorships < ActiveRecord::Migration
  def self.up
    create_table :sponsorships do |t|
      t.integer :animal_id, :null=>false
      t.integer :sponsor_id, :null=>false
      t.date :sponsor_date, :null=>false

      t.timestamps
    end
  end

  def self.down
    drop_table :sponsorships
  end
end
