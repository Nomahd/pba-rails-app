
class VideosController < MediaController

  def summary
    @summary = Video.summary
  end

  def index
    @video = Video.order('broadcast_date DESC, program_num, title').page params[:page]
  end

  def search
    @video = Video.search(params).page params[:page]
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
    @result = Video.bulk(params[:bulk_csv].path)

    if @result[1].length > 0
      render 'bulk/bulk-fail'
    else
      @result[0].each do |instance|
        instance.save
      end
      render 'bulk/bulk-success'
    end
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
    params.require(:video).permit(:program_num, :title, :broadcast_date, :program_name, :description, :guest, :messenger, :bible_book, :bible_chapter_verse, :link, :filename, :original_air, :for_sale)
  end
end

