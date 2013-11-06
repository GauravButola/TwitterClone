class UsersController < ApplicationController
	before_filter :restrict_when_logged_in, :only => [:login, :new]

	def index
		@users = User.all
	end

	def show
		@user = User.find_by_username(params[:id])

		@tweet = Tweet.new
		@tweet.user_id = session[:user_id]
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params) 
		@user.image_path = profile_pic_upload
		if @user.save
			#Show user page insert is successful.
			redirect_to @user
		else
			#Stay on 'new' if record isn't saved.
			render 'new'
		end
	end

	def profile_pic_upload
		uploaded_io = params[:user][:image_path]	
		file_name = uploaded_io.original_filename
		path = Rails.root.join('app/assets/images', 'user_profile_pics', file_name)
		File.open(path, 'wb') do |file|
			file.write(uploaded_io.read)
		end
		return "user_profile_pics/#{file_name}"
	end

	def login
	end

	def login_attempt
		#using sql lower function for case-insensitive username search
		user = User.where('lower(username) = ?', params[:username].downcase).first
		if user && (user.password == params[:password])
			session[:user_id] = user.id
			redirect_to user
		else
			flash[:error] = "Username or password incorrect."
			render 'login'
		end
	end

	def logout
		session[:user_id] = nil
		redirect_to users_path
	end

	def logged_in
		if session[:user_id]
			true
		else
			false
		end
	end

	def restrict_when_logged_in
		if logged_in
			redirect_to welcome_index_path
		end
	end

	private
	def user_params
		params.require(:user).permit(:username, :name, :email, :image_path, :password)	
	end
end
