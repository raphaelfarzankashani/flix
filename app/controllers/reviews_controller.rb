class ReviewsController < ApplicationController

before_action :require_signin
before_action :set_movie

def index
	@reviews = @movie.reviews
end

def new
	@review = @movie.reviews.new
end

def create
	@review = @movie.reviews.new(review_params)
	@review.user = current_user
	if @review.save
		redirect_to movie_reviews_path(@movie), notice: "Review successfully submitted!"
	else
		render :new
	end
end



private

def review_params
    params.require(:review).
      permit(:stars, :comment)
  end
end

def set_movie
	@movie = Movie.find(params[:movie_id])
end

def require_user
	@user = User.find(params[:user_id])
end