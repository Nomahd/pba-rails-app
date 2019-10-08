class CreateCsvs < ActiveRecord::Migration[5.2]
  def change
    create_table :bulks do |t|
      t.binary :csv
      t.timestamps
    end
  end
end
