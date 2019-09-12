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
    ret = []
    result = ActiveRecord::Base.connection.execute("SELECT  `" + params[:model] + "`.`id`, `" + params[:model] + "`.`title`, `" + params[:model] + "`.`broadcast_date` FROM `" + params[:model] + "` ORDER BY broadcast_date DESC, id DESC LIMIT 30")
    result.each do |d|
      ret.push({:id => d[0], :title => d[1], :broadcast_date => d[2]})
    end
    render json: ret
  end

  def select
    model = Object.const_get(params[:model])
    render json: model.find(params[:id])
  end

  def search
    model = Object.const_get(params[:model].capitalize.delete_suffix('s'))
    search = []

    unless params[:text].blank?
      tags = []
      text = params[:text].split
      text.each do |t|
        tagged = model.tagged_with(t).as_json
        unless tagged[0].nil?
          tagged[0].slice!('id', 'title', 'broadcast_date')
          fix_tagged = {:id=>tagged[0]["id"], :title=>tagged[0]["title"], :broadcast_date=>tagged[0]["broadcast_date"]}
        end
        tags.push(fix_tagged)
      end
      puts tags

      array = []
      baseQuery = "SELECT  `" + params[:model] + "`.`id`, `" + params[:model] + "`.`title`, `" + params[:model] + "`.`broadcast_date` FROM `" + params[:model] + "` WHERE "
      query = baseQuery
      text.each_with_index do |t, i|
        unless i == 0
          query += " OR "
        end
        query += "title LIKE '%" + t + "%'"
      end
      result = ActiveRecord::Base.connection.execute(query)
      result.each do |d|
        array.push({:id => d[0], :title => d[1], :broadcast_date => d[2]})
      end
      search = array + tags
      puts search
    end

    unless params[:year].blank? and params[:month].blank?
      array = []
      baseQuery = "SELECT  `" + params[:model] + "`.`id`, `" + params[:model] + "`.`title`, `" + params[:model] + "`.`broadcast_date` FROM `" + params[:model] + "`"

      query = baseQuery
      unless params[:month].blank?
        monthQuery = " WHERE (extract(month from broadcast_date) = '" + params[:month] + "')"
        query += monthQuery
      end

      unless params[:year].blank?
        if params[:month].blank?
          query += " WHERE "
        else
          query += " AND "
        end
        yearQuery = " (extract(year from broadcast_date) = '" + params[:year] + "')"
        query += yearQuery
      end

      result = ActiveRecord::Base.connection.execute(query)
      result.each do |d|
        array.push({:id => d[0], :title => d[1], :broadcast_date => d[2]})
      end
      puts array
      if search.empty?
        search = array
      else
        search = search & array
      end
    end

    render json: search.take(50)
  end
end