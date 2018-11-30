class RemoveIsKeptFromMessages < ActiveRecord::Migration[5.2]
  def change
    remove_column :messages, :is_kept
  end
end
