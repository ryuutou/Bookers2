class UsersController < ApplicationController
	before_action :authenticate_user!

	before_action :ensure_correct_user, {only: [:edit, :update]}

	def index
		@users = User.all
		@user = current_user
		@book = Book.new

	end

	def show
		@user = User.find(params[:id])
		@book = Book.new
		@books = @user.books
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		user = User.find(params[:id])
	 if user.update(user_params)
        flash[:notice] = "successfully"
        redirect_to user_path(user.id)
      	else
      	flash[:alert] = "error"
      	redirect_to user_path(user.id)
      	#@user = User.find(params[:id])
        #render 'users/edit'
     end
	end

	private
	def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
    end

    def ensure_correct_user
  		if current_user.id != params[:id].to_i
    	flash[:notice] = "権限がありません"
    	redirect_to user_path(current_user)
  		end
  	end

end
