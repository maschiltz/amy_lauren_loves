module TagsHelper

  def show_tags_on_side
    tags = Tag.joins(:blog_entries).order("CHAR_LENGTH(name)").distinct
    html = ''
    if !tags.empty?
      tags.each do |tag|
        html += %{
          <li>#{link_to tag.name.upcase, tag_path(tag)}</li><br />
        }
      end
      html = html + '<br />'
    end
    html.html_safe
  end

end
