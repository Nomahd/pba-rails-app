class FixModels < ActiveRecord::Migration[5.2]
  def change
    rename_column :devotions, :release_date, :broadcast_date
    rename_column :audios, :date, :broadcast_date
    rename_column :videos, :date, :broadcast_date
    rename_column :videos, :speaker, :guest
    rename_column :videos, :passage, :bible_book
    change_column :videos, :program_num, :string, after: :id
    add_column :videos, :program_name, :string, after: :broadcast_date
    add_column :videos, :person, :string, after: :guest
    add_column :videos, :bible_chapter_verse, :text, after: :bible_book
    add_column :videos, :for_sale, :boolean, after: :original_air



  end
end
