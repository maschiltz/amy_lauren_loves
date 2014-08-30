class AddPostedToImageLinks < ActiveRecord::Migration
  def change
    add_column :image_links, :posted, :datetime
  end
end
