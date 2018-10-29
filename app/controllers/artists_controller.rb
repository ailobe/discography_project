# frozen_string_literal: true

class ArtistsController < ApplicationController
  def index
    @artists = Artist.order(:name).paginate(page: params[:page],
                                            per_page: 10)
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      redirect_to @artist
    else
      render 'new'
    end
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def show_records
    @artist = Artist.find(params[:artist_id])
    @lps = @artist.lps.order(:name).paginate(page: params[:page],
                                            per_page: 10)
  end

  def update
    @artist = Artist.find(params[:id])

    if @artist.update(artist_params)
      redirect_to @artist
    else
      render 'edit'
    end
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    flash[:success] = 'The artist has been deleted'
    redirect_to artists_path
  end

  private

  def artist_params
    params.require(:artist).permit(:name, :description)
  end
end
