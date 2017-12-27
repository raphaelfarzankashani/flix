class MoviesController < ApplicationController
 before_action :require_signin, except: [:index, :show]
 before_action :require_admin, except: [:index, :show]


  def index
    @movies = Movie.send(movies_scope)
  end

  def show
    @movie = Movie.find(params[:id])
    @fans = @movie.fans
    if current_user
    @user = current_user
    @current_favorite = @user.favorites.find_by(movie: @movie)
    @genres = @movie.genres
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      flash[:notice] = "Movie successfully updated!"
      redirect_to @movie
    else
      render :edit
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie successfully created!"
    else
      render :new
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    if @movie.destroy
      redirect_to movies_url, alert: "Movie successfully deleted!"
    end
  end


private

  def movie_params
    params.require(:movie).
      permit(:title, :description, :rating, :released_on, :total_gross, :cast, :director, :duration, :image_file_name, genre_ids: [])
  end

  def require_admin
    unless current_user_admin?
      redirect_to root_url, alert: "You are not permitted to view that page"
    end
  end
end

def movies_scope
  if params[:scope].in? %w(hits flops upcoming recent)
    params[:scope]
  else
    :released
  end
end

