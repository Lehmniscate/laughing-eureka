class TracksController < ApplicationController

  before_action :require_login
  
  def show
    @track = Track.find_by(id: params[:id])
    render :show
  end

  def new
    @album_id = params[:album_id]
    @action = "new"
    render :new
  end

  def create
    @track = Track.new(track_params)
    @action = "new"

    if @track.save
      redirect_to track_url(@track.id)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def edit
    @track = Track.find_by(id: params[:id])
    @action = "edit"
    if @track.nil?
      redirect_to bands_url
    else
      @album_id = @track.album_id
      render :edit
    end
  end

  def update
    @track = Track.find_by(id: params[:id])
    @action = "edit"

    if @track.update(track_params)
      redirect_to track_url(@track.id)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    @track = Track.find_by(id: params[:id])
    @track.destroy unless @track.nil?
    redirect_to bands_url
  end

  private

  def track_params
    params.require(:track).permit(:name, :album_id, :bonus, :lyrics)
  end
end
