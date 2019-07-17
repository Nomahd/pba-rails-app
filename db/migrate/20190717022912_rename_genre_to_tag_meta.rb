class RenameGenreToTagMeta < ActiveRecord::Migration[5.2]
  def change
    rename_table :genres, :tag_meta
  end
end
