class AddColumnsToAudios < ActiveRecord::Migration[5.2]
  def change
    add_column :audios, :link, :string, after: :passage
  end
end
