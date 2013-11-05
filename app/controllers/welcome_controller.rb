class WelcomeController < ApplicationController
	def index
		if session[:user_id]
			redirect_to User.find(session[:user_id])
		end
	end
end
