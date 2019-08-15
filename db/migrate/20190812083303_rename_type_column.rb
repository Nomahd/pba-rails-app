class RenameTypeColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :people, :type, :category
  end
end
