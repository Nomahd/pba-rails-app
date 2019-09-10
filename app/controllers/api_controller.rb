class ApiController < ApplicationController

  def today_all
    devotion = []
    audio = []
    video = []
    devotion_result = ActiveRecord::Base.connection.execute("SELECT  `devotions`.`id`, `devotions`.`title`, `devotions`.`broadcast_date` FROM `devotions` ORDER BY broadcast_date DESC, id DESC LIMIT 30")
    array_result = ActiveRecord::Base.connection.execute("SELECT  `audios`.`id`, `audios`.`title`, `audios`.`broadcast_date` FROM `audios` ORDER BY broadcast_date DESC, id DESC LIMIT 30")
    video_result = ActiveRecord::Base.connection.execute("SELECT  `videos`.`id`, `videos`.`title`, `videos`.`broadcast_date` FROM `videos` ORDER BY broadcast_date DESC, id DESC LIMIT 30")

    devotion_result.each do |d|
      devotion.push({:id => d[0], :title => d[1], :broadcast_date => d[2]})
    end
    array_result.each do |d|
      audio.push({:id => d[0], :title => d[1], :broadcast_date => d[2]})
    end
    video_result.each do |d|
      video.push({:id => d[0], :title => d[1], :broadcast_date => d[2]})
    end

    render json: { :today => {
        :devotion => devotion.first,
        :audio => audio.first,
        :video => video.first},
                   :batch => {
                       :devotion => devotion,
                       :audio => audio,
                       :video => video
                   }}
  end
  def today
    render json: {:devotion => Devotion.select(:id, :title, :broadcast_date).order(:broadcast_date, :id).last,
                  :audio => Audio.select(:id, :title, :broadcast_date).order(:broadcast_date, :id).last,
                  :video => Video.select(:id, :title, :broadcast_date).order(:broadcast_date, :id).last }
  end

  def batch
    model = Object.const_get(params[:model])
    render json: model.select(:id, :title, :broadcast_date).order('broadcast_date DESC, id DESC').limit(30)
  end

  def select
    model = Object.const_get(params[:model])
    render json: model.find(params[:id])
  end

  def search
    model = Object.const_get(params[:model])
    if params[:text].nil?
      # model.
    end
    puts params[:year].inspect
    puts params[:text].inspect
    # render json: model.api_search(params[:month], params[:year], params:[:text])
  end
end