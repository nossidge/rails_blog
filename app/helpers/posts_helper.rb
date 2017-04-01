module PostsHelper

  # Display any edits as hover-over title text.
  # If the post has been edited, add an asterisk to the date.
  def get_date_display_text(post)
    output = {}

    if post.created_at === post.updated_at
      output[:value] = post.created_at.strftime("%Y/%m/%d at %H:%M")
      output[:title] = "No edits made"
    else
      output[:value] = post.created_at.strftime("%Y/%m/%d at %H:%M") + "*"
      output[:title] = "Last edited: #{post.updated_at.strftime("%Y/%m/%d %H:%M")}"
    end

    output
  end

end
