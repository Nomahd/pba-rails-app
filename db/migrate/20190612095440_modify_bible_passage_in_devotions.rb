class ModifyBiblePassageInDevotions < ActiveRecord::Migration[5.2]
  def change
    remove_column :devotions, :bible_chapter, :integer
    remove_column :devotions, :bible_verse_start, :integer
    remove_column :devotions, :bible_verse_end, :integer
    add_column :devotions, :bible_chapter_verse, :text
  end
end
