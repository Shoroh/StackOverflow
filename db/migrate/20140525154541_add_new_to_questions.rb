class AddNewToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :new, :boolean, default: false
  end
end
