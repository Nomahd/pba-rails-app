class PeopleController < ApplicationController

  def index
    @devotion_people = Person.where(context: :devotion)
    @radio_people = Person.where(context: :audio)
    @tv_people_messenger = Person.where(context: :video, category: :messenger)
    @tv_people_guest = Person.where(context: :video, category: :guest)
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      redirect_to people_path
    else
      render 'new'
    end
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])

    if @person.update(person_params)
      redirect_to people_path
    else
      render 'edit'
    end
  end

  def quick_create
    @person = Person.new(person_params)
    @person.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    Person.destroy(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def destroy_selected
    Person.destroy_selected(params[:selected_audiomessenger],
                            params[:selected_devotionmessenger],
                            params[:selected_videomessenger],
                            params[:selected_videoguest])
    respond_to do |format|
      format.js
    end
  end

  private
  def person_params
    params.require(:person).permit(:name, :context, :category, :photo, :profile)
  end
end
