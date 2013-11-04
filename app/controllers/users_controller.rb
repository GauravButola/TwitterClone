class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params) 
		if @user.save
			#Show user page insert is successful.
			redirect_to @user
		else
			#Stay on 'new' if record isn't saved.
			render 'new'
		end
	end

	private
	def user_params
		params.require(:user).permit(:username, :name, :email, :image_path)	
	end
end
