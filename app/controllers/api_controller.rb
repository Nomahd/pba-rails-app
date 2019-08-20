class ApiController < ApplicationController

  def today
    render json: [ :devotion => Devotion.select(:id, :title, :broadcast_date).order(:broadcast_date).last,
                    :audio => Audio.select(:id, :title, :broadcast_date).order(:broadcast_date).last,
                    :video => Video.select(:id, :title, :broadcast_date).order(:broadcast_date).last]
  end
end