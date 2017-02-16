class AlbumsController < ApplicationController
  def show
    @album = Album.find_by(id: params[:id])
    render :show
  end

  def new
    render :new
  end

  def create
    @album = Album.new(album_params)
    @album.band_id = params[:band_id]

    if @album.save
      redirect_to album_url(@album.id)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    @album = Album.new(album_params)
    @album.id = params[:id]

    if @album.save
      redirect_to album_url(@album.id)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album = Album.find_by(id: params[:id])
    @album.destroy unless @album.nil?
    redirect_to bands_url
  end

  private

  def album_params
    params.require(:album).permit(:name, :band_id, :live)
  end
end
