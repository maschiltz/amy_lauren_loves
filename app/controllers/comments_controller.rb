class CommentsController < ApplicationController

  def show
    @comments = Comment.where("blog_entry_id = #{:blog_entry_id}")
    render :layout => false
  end

end
