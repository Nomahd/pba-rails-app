class ApiController < ApplicationController

  def today_all
    render json: { :today => {
        :devotion => Devotion.select(:id, :title, :broadcast_date).order(:broadcast_date, :id).last,
        :audio => Audio.select(:id, :title, :broadcast_date).order(:broadcast_date, :id).last,
        :video => Video.select(:id, :title, :broadcast_date).order(:broadcast_date, :id).last },
                   :batch => {
                       :devotion => Devotion.select(:id, :title, :broadcast_date).order('broadcast_date DESC, id DESC').limit(30),
                       :audio => Audio.select(:id, :title, :broadcast_date).order('broadcast_date DESC, id DESC').limit(30),
                       :video => Video.select(:id, :title, :broadcast_date).order('broadcast_date DESC, id DESC').limit(30)
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
  # def search
  #   model = Object.const_get(params[:model])
  #   render json: model.api_search(params[:month], params[:year], params:[:text])
  # end
end