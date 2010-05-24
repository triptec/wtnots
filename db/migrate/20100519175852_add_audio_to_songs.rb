class AddAudioToSongs < ActiveRecord::Migration
  def self.up
    add_column :songs, :audio_file_name, :string
    add_column :songs, :audio_content_type, :string
    add_column :songs, :audio_file_size, :integer

  end

  def self.down
    remove_column :songs, :audio_file_name
    remove_column :songs, :audio_content_type
    remove_column :songs, :audio_file_size
  end
end
