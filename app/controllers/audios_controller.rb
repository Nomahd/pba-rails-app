class AudiosController < ApplicationController

  def summary
    @summary = Audio.summary
  end

  def index
    @audio = Audio.order('broadcast_date DESC, program_num, title').page params[:page]
  end

  def search
    @audio = Audio.search(params).order('broadcast_date DESC, program_num, title').page params[:page]
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
    @result = Audio.bulk(params[:bulk_csv].path, params[:bulk_zip].path)

    if @result == false
      render 'bulk/bulk-fail-unequal'
    elsif @result[1].length > 0
      render 'bulk/bulk-fail'
    else
      if Audio.zip_check(params[:bulk_csv].path, params[:bulk_zip].path)
        Audio.zip_upload(params[:bulk_zip].path)
        @result[0].each do |instance|
          instance.save
        end
        render 'bulk/bulk-success'
      else
        render 'bulk/bulk-fail-mismatch'
      end
    end
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
    params.require(:audio).permit(:program_num, :title, :broadcast_date, :program_name, :description, :messenger,  :bible_book, :bible_chapter_verse, :filename, :original_air, :for_sale, :audio_file)
  end
end
