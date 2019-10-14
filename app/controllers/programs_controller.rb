class ProgramsController < ApplicationController

  def index
    @radio_programs = Program.where(context: :audio)
    @tv_programs = Program.where(context: :video)
  end

  def create
    @program = Program.new(program_params)
    @result = Hash.new
    @result[:type] = params[:program][:context]
    respond_to do |format|
      if @program.save
        @result[:result] = :success
        format.js
      else
        @result[:result] = :fail
        @result[:reason] = @program.errors.full_messages.first
        puts @program.errors.inspect
        format.js
      end
    end
  end

  def quick_create
    @program = Program.new(program_params)
    @program.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    Program.destroy(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def destroy_selected
    Program.destroy_selected(params[:selected_audio], params[:selected_video])
    respond_to do |format|
      format.js
    end
  end

  private
  def program_params
    params.require(:program).permit(:name, :context)
  end
end
