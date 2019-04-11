class AddColumnsToDevotions < ActiveRecord::Migration[5.2]
  def change
    add_column :devotions, :messenger, :string
    add_column :devotions, :book_title, :string
  end
end
