class UsersController < ApplicationController

before_action :require_signin, except: [:new, :create]
before_action :require_correct_user, only: [:edit, :update]
before_action :require_admin_delete, only: [:destroy]

	def index
		@users = User.non_admins
	end

	def show
		@user = User.find(params[:id])
    @favorite_movies = @user.favorite_movies
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to @user, notice: "Thanks for signing up!"
		else
			render :new
		end
	end

	def edit
	end

	 def update
    	if @user.update(user_params)
      	flash[:notice] = "Account successfully updated!"
      	redirect_to @user
    	else
      		render :edit
    	end
  	end

  	def destroy
  		if current_user_admin?
      if @user.destroy
  			redirect_to root_url, alert: "Account successfully deleted!"
  		end
    end
  	end

private

  def user_params
    params.require(:user).
      permit(:name, :email, :password, :password_confirmation, :username)
  end

  def require_correct_user
  	@user = User.find(params[:id])
  	unless current_user == @user
  		redirect_to root_url, alert: "You are not permitted to view that page"
  	end
  end

  def require_admin_delete
    @user = User.find(params[:id])
    unless current_user_admin?
      redirect_to root_url, alert: "You are not permitted to delete an account"
    end
  end

end