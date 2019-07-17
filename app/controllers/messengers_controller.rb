class MessengersController < ApplicationController

  def index

  end

  def create
    @messenger = Messenger.new(messenger_params)
    respond_to do |format|
      if @messenger.save
        format.js
      else
        format.js
      end
    end
  end

  private
  def messenger_params
    params.require(:messenger).permit(:name)
  end
end
