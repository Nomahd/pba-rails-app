class FixAudios < ActiveRecord::Migration[5.2]
  def change
    change_column :audios, :program_num, :string, after: :id
    add_column :audios, :program_name, :string, after: :broadcast_date
    rename_column :audios, :speaker, :person
    rename_column :audios, :passage, :bible_book
    add_column :audios, :bible_chapter_verse, :text, after: :bible_book
    add_column :audios, :for_sale, :boolean, after: :original_air
  end
end
