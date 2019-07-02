class CreateMessengers < ActiveRecord::Migration[5.2]
  def change
    create_table :messengers do |t|
      t.string :name
    end
  end
end
