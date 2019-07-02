class MoveDevotionsColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :devotions, :pba_id, :string, after: :id
  end
end
