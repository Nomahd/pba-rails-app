class MessengersController < ApplicationController

  def index

  end

  def create
    @messenger = Messenger.new(messenger_params)
    respond_to do |format|
      if @messenger.save
        format.js
        format.html
        format.json
      else
        format.js
        format.html
        format.json
      end
    end
  end

  private
  def messenger_params
    params.require(:messenger).permit(:name)
  end
end
