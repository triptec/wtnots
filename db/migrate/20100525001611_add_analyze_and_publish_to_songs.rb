class AddAnalyzeAndPublishToSongs < ActiveRecord::Migration
  def self.up
    add_column :songs, :analyze, :boolean, :default => 0
    add_column :songs, :publish, :boolean, :default => 0
    Song.all.each{|s|
      s.publish = false
      s.analyze = false
      s.save
    }
  end

  def self.down
    remove_column :songs, :publish
    remove_column :songs, :analyze
  end
end
