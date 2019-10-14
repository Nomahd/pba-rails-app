class TagMetaController < ApplicationController

  def index
    @genre_tags = TagMeta.where(category: :genre)
    @theme_tags = TagMeta.where(category: :theme)
    @special_tags = TagMeta.where(category: :special)
  end

  def create
    @tag = TagMeta.new(tag_params)
    @result = Hash.new
    @result[:type] = params[:tag][:category]
    respond_to do |format|
      if @tag.save
        @result[:result] = :success
        format.js
      else
        @result[:result] = :fail
        @result[:reason] = @tag.errors.full_messages.first
        puts @tag.errors.inspect
        format.js
      end
    end
  end

  def destroy
    TagMeta.option_destroy(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def destroy_selected
    TagMeta.destroy_selected(params[:selected_genre], params[:selected_theme], params[:selected_special])
    respond_to do |format|
      format.js
    end
  end

  private
  def tag_params
    params.require(:tag).permit(:name, :category)
  end
end
