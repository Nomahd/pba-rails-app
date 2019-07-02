class MoveColumnInDevotions < ActiveRecord::Migration[5.2]
  def change
    change_column :devotions, :bible_chapter_verse, :text, after: :bible_book
  end
end
