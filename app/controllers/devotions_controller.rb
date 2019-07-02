require 'csv'

class DevotionsController < ApplicationController

  def index
    page = params[:page]
    if page == nil
      @devotion = Devotion.page(1)
    else
      @devotion = Devotion.page(page)
    end

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

  def bulk
    render 'common/bulk'
  end

  def bulk_submit

    @result = Devotion.bulk(params[:bulk_csv].path)

    if @result[1].length > 0
      render 'common/bulk-fail'
    else
      render 'common/bulk-success'
    end
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

  private
    def devotion_params
      params.require(:devotion).permit(:pba_id, :title, :release_date, :body, :messenger, :bible_book, :bible_chapter_verse, :genre_list, :theme_list, :special_list)
    end
end
