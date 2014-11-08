class Tag < ActiveRecord::Base
  has_many :blog_entry_tags
  has_many :blog_entries, through: :blog_entry_tags

end
