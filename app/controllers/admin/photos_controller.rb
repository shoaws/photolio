class Admin::PhotosController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @photos = Photo.page(params[:page]).per(12)
  end

  def show
    @photo = Photo.find(params[:id])
    @member = @photo.member
    @comments = @photo.photo_comments.all.order(created_at: :desc)
  end
  
  def destroy
    photo = Photo.find(params[:id])
    member = photo.member
    photo.destroy
    redirect_to admin_member_path(member)
  end
  
  def search
    @search_photos = Photo.search(params[:keyword])
    @photos = @search_photos.page(params[:page]).per(12)
    @keyword = params[:keyword]
    render "index"
  end
  
end
