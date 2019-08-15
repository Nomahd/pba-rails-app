class RenameMessengersToPeople < ActiveRecord::Migration[5.2]
  def change
    rename_table :messengers, :people
    add_column :people, :context, :string
  end
end
