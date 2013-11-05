class Tweet < ActiveRecord::Base
	belongs_to :user
	validates :message,
		:presence => {:message => "You can't post an empty tweet."},
		:length => {:minimum => 1, :maximum => 140, :message => "Your tweet must be less than 140 characters."}
end
