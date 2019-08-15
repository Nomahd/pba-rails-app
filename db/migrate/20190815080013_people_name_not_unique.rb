class PeopleNameNotUnique < ActiveRecord::Migration[5.2]
  def change
    change_column :people, :name, :string, unique: false
  end
end
