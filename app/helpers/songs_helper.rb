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
        str << "<div id=\"c#{comment.id}\" class=\"comment\">" + link_to(comment.user.username, user_path(comment.user)) + " " + h(comment.body) + "<br />"
		    str << time_ago_in_words(comment.created_at) + " ago " + link_to("Reply", reply_song_comment_path(comment.song.id,comment.id),:class => "reply",:comment_id => comment.id, :song_id => comment.song.id)
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
        str << "<div id=\"c#{comment.id}\" class=\"comment\">" + link_to(comment.user.username, user_path(comment.user)) + " " + h(comment.body) + "<br />"
		    str << time_ago_in_words(comment.created_at) + " ago " + link_to("Reply", reply_song_comment_path(comment.song.id,comment.id),:class => "reply",:comment_id => comment.id,:song_id => comment.song.id)
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
