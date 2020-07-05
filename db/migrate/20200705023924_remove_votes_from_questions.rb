class RemoveVotesFromQuestions < ActiveRecord::Migration[6.0]
  def change
    remove_column :questions, :votes, :integer
  end
end
