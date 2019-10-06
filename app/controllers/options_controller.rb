class OptionsController < ApplicationController

  def delete_audios
    Audio.destroy_all
    render 'options/delete-success'
  end

  def delete_devotions
    Devotion.destroy_all
    render 'options/delete-success'
  end

  def delete_videos
    Video.destroy_all
    render 'options/delete-success'
  end
end