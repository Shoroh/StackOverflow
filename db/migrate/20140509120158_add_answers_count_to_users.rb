class AddAnswersCountToUsers < ActiveRecord::Migration

  def up
    add_column :users, :answers_count, :integer, default: 0, null: false

    User.reset_column_information
    User.find_each do |u|
      User.reset_counters u.id, :answers
    end

  end

  def down
    remove_column :users, :answers_count
  end

end
