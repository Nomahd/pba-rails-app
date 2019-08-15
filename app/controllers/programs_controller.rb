class ProgramsController < ApplicationController

  def create
    @program = Program.new(program_params)
    @program.save
    respond_to do |format|
      format.js
    end
  end

  private
  def program_params
    params.require(:program).permit(:name, :context)
  end
end
