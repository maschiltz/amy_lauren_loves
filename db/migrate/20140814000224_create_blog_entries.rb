class CreateBlogEntries < ActiveRecord::Migration
  def change
    create_table :blog_entries do |t|
      t.string :title
      t.text :text
      t.datetime :posted
      t.string :image
      t.string :status

      t.timestamps
    end
  end
end
