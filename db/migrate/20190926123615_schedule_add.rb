class ScheduleAdd < ActiveRecord::Migration[5.2]
  def change
    add_column :schedule, :program, :string, after: :station
    add_column :schedule, :order, :integer, after: :id
  end
end
