class CommentsController < ApplicationController

  def show
    @comments = Array.new
    @comments = comments_for_level(blog_entry_id, 0, 0)
    
    render :layout => false
  end

  def create

    if params[:comment][:parent].nil? || params[:comment][:parent] == ''
      params[:comment][:parent] = 0
    end
    @comment = Comment.new(comment_params)
    @comment.save
 
    @comments = Array.new
    @comments = comments_for_level(@comment.blog_entry_id, 0, 0)
   
    render :layout => false, template: "comments/show", locals: {blog_entry_id: @comment.blog_entry_id, comments: @comments}
  end

  def destroy
    if current_user
      @comment = Comment.find(params[:id])
      blog_entry_id = @comment.blog_entry_id
      
      destroy_tree(@comment)
#      @comment.destroy

      @comments = Array.new
      @comments = comments_for_level(blog_entry_id, 0, 0)

      render :layout => false, template: "comments/show", locals: {blog_entry_id: blog_entry_id, comments: @comments}
    else
      redirect_to root_path
    end
  end

  private
    def destroy_tree(comment)
      children = Comment.where("parent = ?", comment.id)
      if children.length > 0
        children.each do |child|
          destroy_tree(child)
        end
      end
      comment.destroy
    end

    def comments_for_level(blog, level, depth)
      comments = Comment.where("blog_entry_id = ? AND parent = ?", blog, level).order(:created_at)
      retval = Array.new
      comments.each do |comment|
        comment_obj = Hash.new
        comment_obj['depth'] = depth
        comment_obj['text'] = comment.text
        comment_obj['id'] = comment.id
        comment_obj['email'] = comment.email
        retval.push(comment_obj)
        children = comments_for_level(blog, comment.id, depth+1)
        children.each do |child|
          retval.push(child)
        end
      end
      return retval
    end

    def comment_params
      params.require(:comment).permit(:text, :blog_entry_id, :email, :parent)
    end
end
