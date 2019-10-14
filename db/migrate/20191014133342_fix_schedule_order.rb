class FixScheduleOrder < ActiveRecord::Migration[5.2]
  def change
    unless column_exists? :schedules, :order
      add_column :schedules, :order, :integer
    end

    remove_column :schedules, :order
  end
end
