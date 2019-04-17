class ChangeColumnOrderInDevotions < ActiveRecord::Migration[5.2]
  def change
    change_column :devotions, :messenger, :string, after: :passage
    change_column :devotions, :passage, :string, after: :messenger
  end
end
