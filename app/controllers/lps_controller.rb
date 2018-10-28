class LpsController < ApplicationController
  def index
    @lps = Lp.order(:name).paginate(page: params[:page],
                                    per_page: 10)
    @artists = Artist.order(:name)
  end

  def new
    @lp = Lp.new
  end

  def create
    @artist = Artist.find(params[:artist_id])
    @lp = @artist.lps.create(lp_params)
    if @lp.save
      redirect_to artist_lp_path(@artist.id, @lp.id)
    else
      render 'new'
    end
  end

  def show
    @lp = Lp.find(params[:id])
  end

  def update
    @lp = Lp.find(params[:id])
    if @lp.update(lp_params)
      redirect_to artist_lp_path(@lp.artist_id, @lp.id)
    else
      render 'edit'
    end
  end

  def edit
    @lp = Lp.find(params[:id])
  end

  def destroy
    @lp = Lp.find(params[:id])
    @lp.destroy
    redirect_to root_path
  end

  private

  def lp_params
    params.require(:lp).permit(:name, :description)
  end
end
