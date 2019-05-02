class AudiosController < ApplicationController

  def index
    @audio = Audio.all
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

  private
  def audio_params
    params.require(:audio).permit(:title, :date, :description, :speaker, :passage, :audio_file)
  end
end
