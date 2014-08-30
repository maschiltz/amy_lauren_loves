class ImageLink < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "240x240>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
