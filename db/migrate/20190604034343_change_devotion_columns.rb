class ChangeDevotionColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :devotions, :book_title, :string
    add_column :devotions, :pba_id, :string, before: :title
    rename_column :devotions, :date, :broadcast_date
    remove_column :devotions, :passage, :string
    add_column :devotions, :bible_book, :string
    add_column :devotions, :bible_chapter, :integer
    add_column :devotions, :bible_verse_start, :integer
    add_column :devotions, :bible_verse_end, :integer
  end
end
