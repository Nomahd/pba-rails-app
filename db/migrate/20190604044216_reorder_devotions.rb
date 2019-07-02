class ReorderDevotions < ActiveRecord::Migration[5.2]
  def change
    change_column :devotions, :created_at, :datetime, after: :bible_verse_end
    change_column :devotions, :updated_at, :datetime, after: :created_at
  end
end
