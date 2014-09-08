class Comment < ActiveRecord::Base
  attr_accessor :depth

  validates :email, :presence => true

  belongs_to :blog_entry
end
