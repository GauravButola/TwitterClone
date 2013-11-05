class TweetsController < ApplicationController
	def create
		tweet = Tweet.new(tweet_params)
		tweet.user_id = session[:user_id] 
		tweet.save
		
		redirect_to user_path(tweet.user)
	end

	private
	def tweet_params
		params.require(:tweet).permit(:message)
	end
end
