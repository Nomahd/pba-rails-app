class ChangeColumnOrderInDevotions2 < ActiveRecord::Migration[5.2]
  def change
    change_column :devotions, :passage, :string, after: :body
    change_column :devotions, :person, :string, after: :passage
    change_column :devotions, :book_title, :string, after: :person
  end
end
