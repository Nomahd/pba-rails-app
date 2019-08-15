class FixTagMeta < ActiveRecord::Migration[5.2]
  def change
    add_column :tag_meta, :category, :string
    remove_column :tag_meta, :context, :string
  end
end
