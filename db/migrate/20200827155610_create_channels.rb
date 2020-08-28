class CreateChannels < ActiveRecord::Migration[6.0]
  def change
    create_table :channels do |t|
      t.string :name, null: false, unique: true, default: ""

      t.timestamps
    end
  end
end
