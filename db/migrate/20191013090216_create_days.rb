class CreateDays < ActiveRecord::Migration[5.2]
  def change
    create_table :days do |t|
      t.string :name
      t.integer :day_of_week
    end
  end
end
