class CreateDevotions < ActiveRecord::Migration[5.2]
  def change
    create_table :devotions do |t|
      t.string :title
      t.date :date
      t.text :body
      t.string :passage

      t.timestamps
    end
  end
end
