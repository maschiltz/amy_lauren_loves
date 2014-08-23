class CreateImageLinks < ActiveRecord::Migration
  def change
    create_table :image_links do |t|
      t.string :title
      t.string :link
      t.attachment :image

      t.timestamps
    end
  end
end
