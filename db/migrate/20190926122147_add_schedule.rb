class AddSchedule < ActiveRecord::Migration[5.2]
  def change
    create_table :schedule
    add_column :schedule, :station, :string
    add_column :schedule, :start_day, :string
    add_column :schedule, :end_day, :string
    add_column :schedule, :time, :string
    add_column :schedule, :extra_day_start, :string
    add_column :schedule, :extra_day_end, :string
    add_column :schedule, :extra_time, :string
  end
end
