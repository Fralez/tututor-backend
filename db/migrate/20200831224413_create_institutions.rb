class CreateInstitutions < ActiveRecord::Migration[6.0]
  def change
    create_table :institutions do |t|
      t.string :name, null: false
      t.string :email, null: false, unique: true, default: ""
      t.string :description, null: false
      t.string :address, null: false

      t.references :creator, null: false, foreign_key: { to_table: 'users' }

      t.timestamps
    end
  end
end
