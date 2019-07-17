class GenreAddColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :genres, :category, :string, after: :context
  end
end
