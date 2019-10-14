class OptionsController < ApplicationController

  def delete_audios
    DeleteJob.perform_later('Audio')
  end

  def delete_devotions
    DeleteJob.perform_later('Devotion')
  end

  def delete_videos
    DeleteJob.perform_later('Video')
  end

end