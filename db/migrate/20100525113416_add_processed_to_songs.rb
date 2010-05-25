class AddProcessedToSongs < ActiveRecord::Migration
  def self.up
    add_column :songs, :processed, :boolean, :default => 0
    Song.all.each{|s|
      s.processed = 0
      s.save
    }
  end

  def self.down
    remove_column :songs, :processed
  end
end
