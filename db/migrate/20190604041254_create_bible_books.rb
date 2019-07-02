class CreateBibleBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :bible_books do |t|
      t.string :book_ja
      t.string :book_en

      t.timestamps
    end
  end
end
