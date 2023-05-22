class Admin::GenresController < ApplicationController
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to  admin_genres_path(@genre.id)
  end

  def edit

  end

  def update
  end
  
  private
  
  def genre_params
     params.require(:genre).permit(:name)
  end
end
