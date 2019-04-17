class ChangeColumnOrderInAudios < ActiveRecord::Migration[5.2]
  def change
    change_column :audios, :link, :string, after: :passage
  end
end
