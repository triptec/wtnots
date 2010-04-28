module SongsHelper

#<% unless @song.comments.empty? %>
#	 <% @song.comments.each do |comment| %>
#      <p>
#				<% if comment.inverse_replies.empty? %>
#        <%=h comment.body %>
#				<% unless comment.replies.empty? %>
 # 				<% comment.replies.each do |reply| %>
	#					<br />--
	#					<%=h reply.body %>
	#				<% end %>
	#			<% end %>
	#			<% end %>
   #   </p>
 # <% end %>
#<% end %>
  def get_all_replies comments
    str = ""
		comments.each do |comment|
        str << "by: " + link_to(comment.user.username, user_path(comment.user)) + " "+ time_ago_in_words(comment.created_at) + " ago "
		    str << link_to("Reply", reply_song_comment_path(comment.song.id,comment.id))  + "<br />"
		    str << "<div class=\"comment\">" + h(comment.body) + "</div>\n"
      
        if !comment.replies.empty?
		      str << "<div class=\"comment\">\n" + get_all_replies(comment.replies) + "</div>\n"
		    end
    end
    str
  end
	def get_all_comments comments
    str = ""
		comments.each do |comment|
      if comment.inverse_replies.empty?
        str << "by: " + link_to(comment.user.username, user_path(comment.user)) + " "+ time_ago_in_words(comment.created_at) + " ago "
		    str << link_to("Reply", reply_song_comment_path(comment.song.id,comment.id))  + "<br />"
		    str << "<div class=\"comment\">" + h(comment.body) + "</div>\n"
      
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
