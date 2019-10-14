class MoveScheduleCol < ActiveRecord::Migration[5.2]
  def change
    change_column :schedule, :station, :string, after: :program
  end
end
