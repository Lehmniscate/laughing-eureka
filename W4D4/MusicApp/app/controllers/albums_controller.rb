class AlbumsController < ApplicationController

  before_action :require_login

  def show
    @album = Album.find_by(id: params[:id])
    render :show
  end

  def new
    @band_id = params[:band_id]
    render :new
  end

  def create
    album = Album.new(album_params)

    if album.save
      redirect_to album_url(album.id)
    else
      flash.now[:errors] = album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find_by(id: params[:id])
    if @album.nil?
      redirect_to bands_url
    else
      @band_id = @album.band_id
      render :edit
    end
  end

  def update
    @album = Album.find_by(id: params[:id])

    if @album.update(album_params)
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
