class SiteController < ApplicationController
  def index
    @blog_entries = BlogEntry.all
    @image_links = ImageLink.all
    @list = [@blog_entries, @image_links].flatten
    @list = @list.sort_by { |item| item[:posted] }.reverse
  end
end
