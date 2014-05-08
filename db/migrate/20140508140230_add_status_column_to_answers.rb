class AddStatusColumnToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :status, :integer, default: 0
  end
end
