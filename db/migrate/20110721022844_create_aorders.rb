class CreateAorders < ActiveRecord::Migration
  def self.up
    create_table :aorders do |t|
      t.string :name, :limit=> 40, :null=> false

      t.timestamps
    end
  end

  def self.down
    drop_table :aorders
  end
end
