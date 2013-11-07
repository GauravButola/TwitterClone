module ApplicationHelper
	def get_current_user
		if session[:user_id]
			@user = User.find(session[:user_id])
		end
	end

	def make_links(message)
		username_regex = /((^|\s)@[^\s][\w]*)/
			hashtag_regex = /((^|\s)#[^\s][\w]*)/

			if(message =~ username_regex)
				mentions = message.scan(username_regex)

				mentions.each do |m|
					user = m[0].sub('@', '')
					message = message.sub(m[0], link_to(m[0], user) )
				end
			end

		if(message =~ hashtag_regex)
			hashtag = message.scan(hashtag_regex)

			hashtag.each do |m|
				user = m[0].sub('#', '')
				message = message.sub(m[0], link_to(m[0], user) )
			end
		end

		return message
	end

end
