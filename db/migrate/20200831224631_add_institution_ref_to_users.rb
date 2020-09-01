class AddInstitutionRefToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :institution, foreign_key: true
  end
end
