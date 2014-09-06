class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.references :blog_entry, index: true
      t.integer :parent

      t.timestamps
    end
  end
end
