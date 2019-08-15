class FixAgain < ActiveRecord::Migration[5.2]
  def change
    rename_column :videos, :person, :messenger if Video.column_names.include?('person')
    rename_column :audios, :person, :messenger if Audio.column_names.include?('person')
  end
end
