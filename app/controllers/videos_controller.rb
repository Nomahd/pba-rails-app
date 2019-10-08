
class VideosController < MediaController

  def summary
    @summary = Video.summary
  end

  def index
    @video = Video.order('broadcast_date DESC, id DESC').page params[:page]
  end

  def search
    @video = Video.search(params).order('broadcast_date DESC, id DESC').page params[:page]
    render 'index'
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

  def bulk_submit
    id = Video.save(params[:bulk_csv].tempfile.read)
    redirect_to bulk_progress_videos_path csv_id: id
  end

  def bulk_execute
    Video.bulk(Bulk.find(params[:id]).csv.force_encoding("UTF-8").split("\r\n"), params[:id])
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

  def destroy_selected
    Video.destroy(params[:selected])
    redirect_to videos_path
  end


  private
  def video_params
    params.require(:video).permit(:program_num, :title, :broadcast_date, :program_name, :description, :guest, :messenger, :bible_book, :bible_chapter_verse, :link, :filename, :original_air, :for_sale, :genre_list, :theme_list, :special_list)
  end
end

