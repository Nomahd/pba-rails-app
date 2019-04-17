class DevotionsController < ApplicationController

  def index
    @devotion = Devotion.all
  end

  def show
    @devotion = Devotion.find(params[:id])
  end

  def new
    @devotion = Devotion.new
  end

  def edit
    @devotion = Devotion.find(params[:id])
  end

  def create
    @devotion = Devotion.new(devotion_params)
    if @devotion.save
      redirect_to @devotion
    else
      render 'new'
    end
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
      params.require(:devotion).permit(:title, :date, :body, :passage, :messenger, :book_title)
    end
end
