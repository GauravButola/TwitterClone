class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	helper_method :make_mention_links
	before_filter :get_user

	def get_user
		if session[:user_id]
			@user = User.find(session[:user_id])
		end
	end

	def make_mention_links(message)
		username_regex = /(@[^\s][\w\d]*)/
			if(message =~ username_regex)
				mentions = message.scan(username_regex)

				mentions.each do |m|
					user = m[0].sub('@', '')
					message = message.sub(m[0], view_context.link_to(m[0], user) )
				end
			end
		return message
	end
end
