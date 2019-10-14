class RenameSchedule < ActiveRecord::Migration[5.2]
  def change
    rename_table :schedule, :schedules
  end
end
