class AddColumnToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :type, :string, after: :context
  end
end
