class BiggerBlob < ActiveRecord::Migration[5.2]
  def change
    change_column :bulks, :csv, :binary, limit: 10.megabyte
  end
end
