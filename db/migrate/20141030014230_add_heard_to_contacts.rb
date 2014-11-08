class AddHeardToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :heard, :string
  end
end
