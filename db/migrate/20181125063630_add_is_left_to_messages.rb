class AddIsLeftToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :is_kept, :boolean
  end
end
