class AddColumnsToAudiosAndVideos < ActiveRecord::Migration[5.2]
  def change
    add_column :audios, :original_air, :date, after: :filename
    add_column :audios, :program_num, :integer, after: :original_air
    add_column :videos, :filename, :date, after: :link
    add_column :videos, :original_air, :date, after: :filename
    add_column :videos, :program_num, :integer, after: :original_air
  end
end
