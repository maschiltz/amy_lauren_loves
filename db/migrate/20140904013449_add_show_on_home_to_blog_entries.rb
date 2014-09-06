class AddShowOnHomeToBlogEntries < ActiveRecord::Migration
  def change
    change_table :blog_entries do |t|
      t.integer :show_on_home
    end
  end
end
