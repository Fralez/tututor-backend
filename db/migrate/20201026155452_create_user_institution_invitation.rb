class CreateUserInstitutionInvitation < ActiveRecord::Migration[6.0]
  def change
    create_table :user_institution_invitations do |t|
        t.references :user, null: false, foreign_key: true
        t.references :institution, null: false, foreign_key: true

        t.timestamps null: false
    end
  end
end
