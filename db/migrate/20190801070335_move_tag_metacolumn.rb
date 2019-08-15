class MoveTagMetacolumn < ActiveRecord::Migration[5.2]
  def change
    change_column :tag_meta, :category, :string, after: :name
  end
end
