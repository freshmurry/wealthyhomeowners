class PhotosController < ApplicationController

  def create
    @home = Home.find(params[:id])
    @photos = @home.photos

    if params[:images]
        params[:images].each do |img|
        @home.photos.create(image: img)
      end

      @photos = @home.photos
      redirect_back(fallback_location: request.referer, notice: "Saved...")
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @home = @photo.home

    @photo.destroy
    @photos = Photo.where(home_id: @home.id)

    respond_to :js
  end
end