class RemoveCategoryFromTagMeta < ActiveRecord::Migration[5.2]
  def change
    remove_column :tag_meta, :category, :string
  end
end
