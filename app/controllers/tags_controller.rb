class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @blog_entries = @tag.blog_entries
    @list = @blog_entries.sort_by { |item| item[:posted] }.reverse
    @features = BlogEntry.where("featured > 0").order('featured ASC')

    render "site/index"
  end
end
