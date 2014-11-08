class BlogEntryTag < ActiveRecord::Base
  belongs_to :blog_entry
  belongs_to :tag
end
