class MakeMessengersUnique < ActiveRecord::Migration[5.2]
  def change
    add_index :messengers, :name, unique: true
  end
end
