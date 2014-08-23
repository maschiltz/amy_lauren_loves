class SiteController < ApplicationController
  def index
    @blog_entries = BlogEntry.all
    @image_links = ImageLink.all
  end
end
