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
    db_model_name = params[:model].downcase + 's'
    result = ActiveRecord::Base.connection.execute("SELECT  `" + db_model_name + "`.`id`, `" + db_model_name + "`.`title`, `" + db_model_name + "`.`broadcast_date` FROM `" + db_model_name + "` ORDER BY broadcast_date DESC, id DESC LIMIT 30")
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
    model = Object.const_get(params[:model])
    search_results = []
    db_model_name = params[:model].downcase.pluralize

    # Checking text
    unless params[:text].blank?
      text = params[:text].split

      # Search tags
      text.each do |t|
        tagged = model.tagged_with(t).as_json
        unless tagged.blank?
          tagged.each do |tag|
            tag.slice!('id', 'title', 'broadcast_date')
            tag_result = {:id => tag['id'], :title=> tag['title'], :broadcast_date=> tag['broadcast_date']}
            search_results |= [tag_result]
            puts "search tags"
            puts search_results.inspect
          end
        end
      end

      # Search title
      query_base_title = "SELECT  `" + db_model_name + "`.`id`, `" + db_model_name + "`.`title`, `" + db_model_name + "`.`broadcast_date` FROM `" + db_model_name + "` WHERE "
      query_title = query_base_title
      text.each_with_index do |t, i|
        unless i == 0
          query_title += " OR "
        end
        query_title += "title LIKE '%" + t + "%'"
      end
      title_results = ActiveRecord::Base.connection.execute(query_title)
      title_results.each do |d|
        puts d.inspect
        title_result_hash = {:id => d[0], :title => d[1], :broadcast_date => d[2]}
        search_results |= [title_result_hash]
        puts "search titles"
        puts search_results.inspect
      end

      # Search description for Audio and Video
      if model == Audio or model == Video
        query_base_description = "SELECT  `" + db_model_name + "`.`id`, `" + db_model_name + "`.`title`, `" + db_model_name + "`.`broadcast_date` FROM `" + db_model_name + "` WHERE "
        query_description = query_base_description
        text.each_with_index do |t, i|
          unless i == 0
            query_description += " OR "
          end
          query_description += "description LIKE '%" + t + "%'"
        end
        description_results = ActiveRecord::Base.connection.execute(query_description)
        description_results.each do |d|
          description_results_hash = {:id => d[0], :title => d[1], :broadcast_date => d[2]}
          search_results |= [description_results_hash]
          puts "search descriptions"
          puts search_results.inspect
        end

        #Search body for Devotion
      elsif model == Devotion
        body_search_array = []
        query_base_body = "SELECT  `" + db_model_name + "`.`id`, `" + db_model_name + "`.`title`, `" + db_model_name + "`.`broadcast_date` FROM `" + db_model_name + "` WHERE "
        query_body = query_base_body
        text.each_with_index do |t, i|
          unless i == 0
            query_body += " OR "
          end
          query_body += "body LIKE '%" + t + "%'"
        end
        title_results = ActiveRecord::Base.connection.execute(query_body)
        title_results.each do |d|
          body_search_array.push({:id => d[0], :title => d[1], :broadcast_date => d[2]})
        end
        search_results |= body_search_array
        puts "search body"
        puts search_results.inspect
      end
    end

    # Search date
    unless params[:year].blank? and params[:month].blank?
      date_search_array = []
      query_base_date = "SELECT  `" + db_model_name + "`.`id`, `" + db_model_name + "`.`title`, `" + db_model_name + "`.`broadcast_date` FROM `" + db_model_name + "`"

      query_date = query_base_date
      unless params[:month].blank?
        monthQuery = " WHERE (extract(month from broadcast_date) = '" + params[:month] + "')"
        query_date += monthQuery
      end

      unless params[:year].blank?
        if params[:month].blank?
          query_date += " WHERE "
        else
          query_date += " AND "
        end
        yearQuery = " (extract(year from broadcast_date) = '" + params[:year] + "')"
        query_date += yearQuery
      end

      title_results = ActiveRecord::Base.connection.execute(query_date)
      title_results.each do |d|
        date_search_array.push({:id => d[0], :title => d[1], :broadcast_date => d[2]})
      end
      if search_results.empty?
        search_results = date_search_array
        puts "search only dates"
        puts search_results.inspect
      else
        search_results = search_results & date_search_array
        puts "search dates"
        puts search_results.inspect
      end
    end
    puts "final result"
    puts search_results.inspect
    sorted_search_results = search_results.sort_by {|obj| obj[:broadcast_date]}.reverse
    render json: sorted_search_results.take(50)
  end
end