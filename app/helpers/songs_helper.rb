module SongsHelper
  def links_to_song(song)
    str = ""
    str << link_to('Back', songs_path) 
    if correct_user(song.user.id)
      str << " | " + link_to('Edit', edit_song_path(song))  + " | "
      str << link_to('Delete', {:action => "destroy", :id =>@song}, :confirm => "Are you sure?")
    end
    return str
  end
  def link_to_comment
  str =""
    if current_user
      str << "<h2><a id=\"toggle_new_comment\" href=\"#\">Comment</a></h2>"
      str << render(:partial => "comments/new_comment", :object => @comment = Comment.new, :locals => { :button_name => 'Comment' })
      return str
    end
    return str
  end

  def link_to_reply(comment)
    if current_user
      return link_to("Reply", reply_song_comment_path(comment.song.id,comment.id),:class => "reply",:comment_id => comment.id, :song_id => comment.song.id)
    else 
      return ""
    end
  end

  def get_all_replies comments
    str = ""
    comments.each do |comment|
      str << "<div id=\"c#{comment.id}\" class=\"comment\">" 
      str << link_to(comment.user.username, user_path(comment.user)) 
      str << " " + h(comment.body) + "<br />"
      str << time_ago_in_words(comment.created_at) + " ago " 
      #str << link_to("Reply", reply_song_comment_path(comment.song.id,comment.id),:class => "reply",:comment_id => comment.id, :song_id => comment.song.id)
      str << link_to_reply(comment)
      str << "</div>\n"

      if !comment.replies.empty?
        str << "<div class=\"comment\">\n" + get_all_replies(comment.replies) + "</div>\n"
      end
    end
    str
  end
  def get_all_comments comments
    str = ""
    comments.all(:order => "id desc").each do |comment|
      if comment.inverse_replies.empty?
        str << "<div id=\"c#{comment.id}\" class=\"comment\">"
        str << link_to(comment.user.username, user_path(comment.user)) 
        str << " " + h(comment.body) + "<br />"
        str << time_ago_in_words(comment.created_at) + " ago " 
        str << link_to_reply(comment)
        str << "</div>\n"

        if !comment.replies.empty?
          str << "<div class=\"comment\">\n" + get_all_replies(comment.replies) + "</div>\n"
        end
      end
    end
    str
  end

  def print_all_comments song
    unless song.comments.empty?
      return get_all_comments(song.comments)
    end
  end
end
