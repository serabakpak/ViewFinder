class UsersController < ApplicationController
	def new
		@user = User.new

	end

	def create
		@user = User.new(user_params)		
		if @user.save
			login(@user)
			flash[:notice] = "Successfully logged in."
			redirect_to @user
		else
			flash[:error] = @user.errors.full_messages.to_sentence
			redirect_to photos_path
		end
	end

	def show
		@user = User.find_by_id(params[:id])
	end

	def edit
		@user = User.find_by_id(params[:id])
	end

	def update
		@user = User.find_by_id(params[:id])
		@user.update_attributes(user_params)
		redirect_to @user
	end

	def destroy
		@user = User.find_by_id(params[:id])
		@user.destroy
		redirect_to photos_path
	end

	private
		def user_params
			params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
		end
end
