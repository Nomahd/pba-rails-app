class Rename < ActiveRecord::Migration[5.2]
  def change
    rename_table :csvs, :bulks
  end
end
