class FixPeopleToMessenger < ActiveRecord::Migration[5.2]
  def change
    rename_column :videos, :people, :messenger if Video.column_names.include?('people')
    rename_column :audios, :people, :messenger if Audio.column_names.include?('people')
  end
end
