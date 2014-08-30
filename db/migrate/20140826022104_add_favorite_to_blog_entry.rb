class AddFavoriteToBlogEntry < ActiveRecord::Migration
  def change
    add_column :blog_entries, :favorite, :integer
  end
end
