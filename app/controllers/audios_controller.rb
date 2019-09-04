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
    csv_path = nil
    zip_path = nil
    if params[:bulk_csv] != nil
      csv_path = params[:bulk_csv].path
    end
    if params[:bulk_zip] != nil
      zip_path = params[:bulk_zip].path
    end

    @result = Audio.bulk(csv_path, zip_path)

    if @result == false
      render 'bulk/bulk-fail-unequal'
    elsif @result == 'zip'
      render 'bulk/bulk-zip-success'
    elsif @result[1].length > 0
      render 'bulk/bulk-fail'
    else
      if zip_path and csv_path != nil
        if Audio.zip_check(params[:bulk_csv].path, params[:bulk_zip].path)
          Audio.zip_upload(params[:bulk_zip].path)
        else
          render 'bulk/bulk-fail-mismatch' and return
        end
      end
        @result[0].each do |instance|
          instance.save
        end
        render 'bulk/bulk-success'
    end
  end

  def edit
    @audio = Audio.find(params[:id])
  end

  def update
    @audio = Audio.find(params[:id])
    if @audio.audio_file.nil?
      @audio.audio_file = 'ignore'
    end

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
