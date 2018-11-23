class AddAddressToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :address, :string
  end
end
