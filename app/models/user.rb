class User < ActiveRecord::Base
	validates :name, 
						:presence => {:message => "You must have a name! don't you?"},
						:length => {:minimum => 1, :maximum => 20, :message => "Name must be in 1-20 character range"}

	validates :username, 
						:presence => {:message => "Please create a username."},
						:uniqueness => {:message => "username already exists."},
						:length => {:minimum => 3, :maximum => 20, :message => "username must be in 3-20 character range"}

	validates :email, 
						:presence => {:message => "Email is required."},
						:uniqueness => {:message => "Given email address is already associated with another account."},
						:format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => "That doesn't quite look like an email, eh?"}

end
