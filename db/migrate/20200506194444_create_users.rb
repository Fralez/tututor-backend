# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email,              null: false, unique: true, default: ""
      t.string :password_digest,    null: false
      t.string :identity_number,    null: false, unique: true
      t.string :name,               null: false, default: ""
      t.string :description,        null: true, default: ""
      t.integer :gender,            null: false, default: 0
      t.datetime :birth_date,       null: false
      t.integer :reputation,        null: true, default: 1
      t.boolean :admin,             null: false, default: false

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :identity_number,      unique: true
  end
end
