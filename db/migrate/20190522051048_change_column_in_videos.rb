class ChangeColumnInVideos < ActiveRecord::Migration[5.2]
  def change
    change_column :videos, :filename, :string
  end
end
