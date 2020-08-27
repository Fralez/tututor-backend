class AddMessagesRefToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :messages, foreign_key: true
  end
end
