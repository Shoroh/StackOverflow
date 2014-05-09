class AddAnswersCountToQuestions < ActiveRecord::Migration

  def up
    add_column :questions, :answers_count, :integer, default: 0, null: false

    Question.reset_column_information
    Question.find_each do |u|
      Question.reset_counters u.id, :answers
    end

  end

  def down
    remove_column :questions, :answers_count
  end

end
