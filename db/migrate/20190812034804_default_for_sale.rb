class DefaultForSale < ActiveRecord::Migration[5.2]
  def change
    change_column :videos, :for_sale, :boolean, :default => false
    change_column :audios, :for_sale, :boolean, :default => false

  end
end
