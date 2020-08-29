class CreateChannels < ActiveRecord::Migration[6.0]
  def change
    create_table :channels do |t|
      t.string :name, null: false, unique: true, default: ""

      t.references :user_one, null: false, foreign_key: { to_table: 'users' }
      t.references :user_two, null: false, foreign_key: { to_table: 'users' }

      t.timestamps
    end
  end
end
