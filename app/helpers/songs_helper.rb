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
	def get_all_comments comments
		i=0
		str=""
		comments.each do |comment|
		i+=1
			if comment.inverse_replies.empty? && !comment.replies.empty?
				str << "<div>" + h(comment.body) + "</div>\n"
				str << "<div id=sub>\n" + get_all_comments(comment.replies) + "</div>\n"
			elsif !comment.inverse_replies.empty? && !comment.replies.empty? && comment.id != i
				str << "<div>" + h(comment.body) + "</div>\n"
				str << "<div id=sub>\n" + get_all_comments(comment.replies) + "</div>\n"
			elsif !comment.inverse_replies.empty? && comment.replies.empty? && comment.id != i
				str << "<div>" + h(comment.body) + "</div>\n"
			elsif comment.inverse_replies.empty? && comment.replies.empty?
				str << "<div>" + h(comment.body) + "</div>\n"
			end
		end
		str
	end

	def print_all_comments song
		unless song.comments.empty?
			return "<br />called gac: <br />" + get_all_comments(song.comments)
		end
	end
end
