class PeopleController < ApplicationController

  def create
    @person = Person.new(person_params)
    @person.save
    respond_to do |format|
      format.js
    end
  end

  private
  def person_params
    params.require(:person).permit(:name, :context, :category)
  end
end
