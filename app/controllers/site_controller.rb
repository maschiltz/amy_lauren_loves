class SiteController < ApplicationController
  def index
    @blog_entries = BlogEntry.where(show_on_home: 1..Float::INFINITY)
    @image_links = ImageLink.where(show_on_home: 1..Float::INFINITY)
    @list = [@blog_entries, @image_links].flatten
    @list = @list.sort_by { |item| item[:show_on_home] }
    @slides = Slide.where("active > 0").order('`order` ASC')
  end
end
