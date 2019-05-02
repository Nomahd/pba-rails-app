class VideosController < ApplicationController
  def index
    @video = Video.all
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      redirect_to @video
    else
      render 'new'
    end
  end

  def show
    @video = Video.find(params[:id])
  end

  def new
    @video = Video.new
  end

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    if @video.update(video_params)
      redirect_to @video
    else
      render 'edit'
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    redirect_to videos_path
  end

  private
  def video_params
    params.require(:video).permit(:title, :date, :description, :speaker, :passage, :link)
  end
end
