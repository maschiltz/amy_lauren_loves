class CreateBlogEntryTags < ActiveRecord::Migration
  def change
    create_table :blog_entry_tags do |t|
      t.references :blog_entry, index: true
      t.references :tag, index: true

      t.timestamps
    end
  end
end
