class BlogEntry < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "240x240>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  has_many :blog_entry_tags
  has_many :tags, through: :blog_entry_tags

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
