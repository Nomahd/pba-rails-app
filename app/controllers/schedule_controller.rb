class ScheduleController < ApplicationController

  def index
    @schedules = Schedule.all
  end

  def create
    error_array = []
    @schedules = Schedule.bulk(params[:bulk_csv].path)
    @schedules.each do |schedule|
      unless schedule.save
        error_array.push(schedule)
      end
    end

    if error_array.length > 0
      Schedule.destroy_all
      @errors = error_array
      render 'error'
    else
      redirect_to schedule_index_path
    end
  end

  def destroy_selected
    Schedule.destroy_all
    redirect_to schedule_index_path
  end
end
