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
	def get_all_comments comments, sep = ""
		i=0
		str=""
		comments.each do |comment|
		i+=1
			if comment.inverse_replies.empty? && !comment.replies.empty?
				str << "<br />has replies " + h(comment.body) + "<br />"
				sep+= "--"
				str << sep + get_all_comments(comment.replies,sep)
			elsif !comment.inverse_replies.empty? && !comment.replies.empty? && comment.id != i
				str << "is and has replies " + h(comment.body) + "<br />"
				sep+="--"
				str << sep + get_all_comments(comment.replies,sep)
			elsif comment.inverse_replies.empty? && comment.replies.empty?
				str << "<br />atom " + h(comment.body) + "<br />"
			elsif !comment.inverse_replies.empty? && comment.replies.empty? && comment.id != i
				str << "last reply #{i.to_s} " + h(comment.body)
			end
			sep=""
		end
		str
	end

	def print_all_comments song
		unless song.comments.empty?
			return "<br />called gac: <br />" + get_all_comments(song.comments)
		end
	end
end
