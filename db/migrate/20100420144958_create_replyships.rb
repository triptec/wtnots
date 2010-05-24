class CreateReplyships < ActiveRecord::Migration
  def self.up
    create_table :replyships do |t|
      t.integer :comment_id
      t.integer :reply_id

      t.timestamps
    end
  end

  def self.down
    drop_table :replyships
  end
end
