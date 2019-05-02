class AddColumnToAudios < ActiveRecord::Migration[5.2]
  def change
    add_column :audios, :filename, :string, after: :link
  end
end
