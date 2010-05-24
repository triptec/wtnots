class CreateSongs < ActiveRecord::Migration
  def self.up
    create_table :songs do |t|
      t.string :title, :null => false
      t.text :description, :null => false
      t.references :user, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :songs
  end
end
