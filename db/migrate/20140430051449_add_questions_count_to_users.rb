class AddQuestionsCountToUsers < ActiveRecord::Migration
  def up
    add_column :users, :questions_count, :integer, default: 0, null: false

    User.reset_column_information
    User.find_each do |u|
      User.reset_counters u.id, :questions
    end

  end

  def down
    remove_column :users, :questions_count
  end
end
