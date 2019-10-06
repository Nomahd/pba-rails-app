class ExpandPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :profile, :text, after: :category
    add_column :people, :photo_link, :string, after: :profile
  end
end
