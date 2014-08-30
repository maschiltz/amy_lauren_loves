class FixFeaturedColumnName < ActiveRecord::Migration
  def self.up
    rename_column :blog_entries, :favorite, :featured
  end
end
