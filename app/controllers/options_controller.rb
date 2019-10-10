class OptionsController < ApplicationController

  def tags
    @genre_tags = TagMeta.where(category: :genre)
    @theme_tags = TagMeta.where(category: :theme)
    @special_tags = TagMeta.where(category: :special)
  end

  def tag_create
    @tag = TagMeta.new(tag_params)
    respond_to do |format|
      if @tag.save
        format.js
      else
        format.js
      end
    end
  end

  def tag_destroy
    TagMeta.option_destroy(params[:id])
    redirect_to options_tags_path
  end

  def tag_destroy_selected
    TagMeta.destroy_selected(params[:selected_genre], params[:selected_theme], params[:selected_special])
    redirect_to options_tags_path
  end

  def delete_audios
    DeleteJob.perform_later('Audio')
  end

  def delete_devotions
    DeleteJob.perform_later('Devotion')
  end

  def delete_videos
    DeleteJob.perform_later('Video')
  end

  private
  def tag_params
    params.require(:tag).permit(:name, :category)
  end

end