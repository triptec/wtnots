class CreatePuids < ActiveRecord::Migration
  def self.up
    create_table :puids do |t|
      t.string :puid
      t.integer :song_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :puids
  end
end
