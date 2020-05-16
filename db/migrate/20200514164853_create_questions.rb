class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.integer :votes, default: 0

      t.timestamps
    end
  end
end
