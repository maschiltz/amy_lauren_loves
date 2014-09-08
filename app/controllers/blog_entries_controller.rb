class BlogEntriesController < ApplicationController

  def new
    if current_user
      @blog_entry = BlogEntry.new
    else
      redirect_to root_path
    end
  end

  def edit
    if current_user
      @blog_entry = BlogEntry.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def update
    if current_user
      @blog_entry = BlogEntry.find(params[:id])

      if params[:blog_entry][:posted] == ''
        params[:blog_entry][:posted] = Time.now
      end      
        
      if params[:blog_entry][:posted] =~ /\A(\d{2})\/(\d{2})\/(\d{4})\z/
        params[:blog_entry][:posted] = "#{$3}-#{$1}-#{$2}"
      end

      if @blog_entry.update(blog_entry_params)
        redirect_to @blog_entry
      else
        render 'edit'
      end
    else
      redirect_to root_path
    end
  end

  def create
    if current_user
      
      if params[:blog_entry][:posted] == ''
        params[:blog_entry][:posted] = Time.now
      end      
        
      if params[:blog_entry][:posted] =~ /\A(\d{2})\/(\d{2})\/(\d{4})\z/
        params[:blog_entry][:posted] = "#{$3}-#{$1}-#{$2}"
      end

      @blog_entry = BlogEntry.new(blog_entry_params)

      @blog_entry.save
      redirect_to @blog_entry
    else
      redirect_to root_path
    end
  end

  def show
    @blog_entry = BlogEntry.find(params[:id])
    @features = BlogEntry.where("featured > 0").order('featured ASC')
#    @comments = Comment.where("blog_entry_id = ?", params[:id])

    @comments = Array.new
    @comments = comments_for_level(params[:id], 0, 0)
    puts @comments.inspect()
  end

  def destroy
    if current_user
      @blog_entry = BlogEntry.find(params[:id])
      @blog_entry.destroy
      render :text => "Deleted"
    else
      redirect_to root_path
    end
  end

  def index
    @blog_entries = BlogEntry.all
    @list = @blog_entries.sort_by { |item| item[:posted] }.reverse
    @features = BlogEntry.where("featured > 0").order('featured ASC')
  end

  private
    def blog_entry_params
      params.require(:blog_entry).permit(:title, :text, :posted, :image, :featured, :show_on_home)
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


end
