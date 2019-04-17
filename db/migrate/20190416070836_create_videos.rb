class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.string :title
      t.date :date
      t.text :description
      t.string :link
      t.string :speaker
      t.string :passage

      t.timestamps
    end
  end
end
