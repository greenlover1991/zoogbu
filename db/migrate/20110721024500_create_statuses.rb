class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.string :name, :limit=> 40, :null=> false
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :statuses
  end
end
