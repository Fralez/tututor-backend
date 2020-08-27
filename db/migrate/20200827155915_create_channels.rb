class CreateChannels < ActiveRecord::Migration[6.0]
  def change
    create_table :channels do |t|
      t.string :name, null: false, unique: true, default: ""

      t.references :users, null: false, foreign_key: true
      t.references :messages, foreign_key: true
    end
  end
end
