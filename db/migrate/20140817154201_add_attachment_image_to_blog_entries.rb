class AddAttachmentImageToBlogEntries < ActiveRecord::Migration
  def self.up
    change_table :blog_entries do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :blog_entries, :image
  end
end
