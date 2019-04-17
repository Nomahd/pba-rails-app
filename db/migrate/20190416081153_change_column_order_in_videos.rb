class ChangeColumnOrderInVideos < ActiveRecord::Migration[5.2]
  def change
    change_column :videos, :link, :string, after: :passage
  end
end
