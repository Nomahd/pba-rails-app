class MediaController < ApplicationController
  protected

  def index
    instance_var = instance_variable_get("@#{controller_name.singularize}")
    instance_var = Video.order(:broadcast_date, :program_num, :title).page params[:page]
  end
end