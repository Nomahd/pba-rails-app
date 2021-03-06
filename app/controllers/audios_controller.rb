class AudiosController < ApplicationController

  def summary
    @summary = Audio.summary
  end

  def index
    @audio = Audio.order('broadcast_date DESC, id DESC').page params[:page]
  end

  def search
    @audio = Audio.search(params).order('broadcast_date DESC, id DESC').page params[:page]
    render 'index'
  end

  def create
    @audio = Audio.new(audio_params)
    if @audio.save
      redirect_to @audio
    else
      render 'new'
    end
  end

  def show
    @audio = Audio.find(params[:id])
  end

  def new
    @audio = Audio.new
  end

  def bulk_submit
    id = Audio.save(params[:bulk_csv].tempfile.read)
    redirect_to bulk_progress_audios_path csv_id: id
  end

  def bulk_execute
    Audio.bulk(Bulk.find(params[:id]).csv.force_encoding("UTF-8").split("\r\n"), params[:id])
  end

  def edit
    @audio = Audio.find(params[:id])
  end

  def update
    @audio = Audio.find(params[:id])

    if @audio.update(audio_params)
      redirect_to @audio
    else
      render 'edit'
    end
  end

  def destroy
    @audio = Audio.find(params[:id])
    @audio.destroy

    redirect_to audios_path
  end

  def destroy_selected
    Audio.destroy(params[:selected])
    redirect_to audios_path
  end

  private
  def audio_params
    params.require(:audio).permit(:program_num, :title, :broadcast_date, :program_name, :description, :messenger,  :bible_book, :bible_chapter_verse, :filename, :original_air, :for_sale, :audio_file,  :genre_list, :theme_list, :special_list)
  end
end
