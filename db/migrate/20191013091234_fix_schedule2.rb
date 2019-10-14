class FixSchedule2 < ActiveRecord::Migration[5.2]
  def change
    add_column :schedule, :category, :string, after: :id
  end
end
