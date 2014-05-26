class RemoveNewToQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :new, :string
  end
end
