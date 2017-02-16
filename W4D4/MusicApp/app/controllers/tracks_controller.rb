class TracksController < ApplicationController
  def show

  end

  def new
    render :new
  end

  def create

  end

  def edit
    render :edit
  end

  def update

  end

  def destroy

  end

  private

  def track_params
    params.require(:track).permit(:name, :album_id, :bonus, :lyrics)
  end
end
