class Comment < ActiveRecord::Base
  validates :email, :presence => true

  belongs_to :blog_entry
end
