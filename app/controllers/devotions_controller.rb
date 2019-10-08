class DevotionsController < ApplicationController

  def summary
    @summary = Devotion.summary
  end

  def index
    @devotion = Devotion.order('broadcast_date DESC, id DESC').page params[:page]
  end

  def search
    @devotion = Devotion.search(params).order('broadcast_date DESC, id DESC').page params[:page]
    render 'index'
  end

  def create
    @devotion = Devotion.new(devotion_params)
    if @devotion.save
      redirect_to @devotion
    else
      render 'new'
    end
  end

  def show
    @devotion = Devotion.find(params[:id])
  end

  def new
    @devotion = Devotion.new
  end

  def bulk_submit
    id = Devotion.save(params[:bulk_csv].tempfile.read)
    redirect_to bulk_progress_devotions_path csv_id: id
  end

  def bulk_execute
    Devotion.bulk(Bulk.find(params[:id]).csv.force_encoding("UTF-8").split("\r\n"), params[:id])
  end

  def edit
    @devotion = Devotion.find(params[:id])
  end

  def update
    @devotion = Devotion.find(params[:id])
    if @devotion.update(devotion_params)
      redirect_to @devotion
    else
      render 'edit'
    end
  end

  def destroy
    @devotion = Devotion.find(params[:id])
    @devotion.destroy

    redirect_to devotions_path
  end

  def destroy_selected
    Devotion.destroy(params[:selected])
    redirect_to devotions_path
  end

  private

  def devotion_params
    params.require(:devotion).permit(:pba_id, :title, :broadcast_date, :body, :messenger, :bible_book, :bible_chapter_verse, :genre_list, :theme_list, :special_list)
  end
end
