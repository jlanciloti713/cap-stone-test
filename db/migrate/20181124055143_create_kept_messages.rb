class CreateKeptMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :kept_messages do |t|
      t.boolean :is_kept
      t.integer :message_id
      t.integer :user_id

      t.timestamps
    end
  end
end
