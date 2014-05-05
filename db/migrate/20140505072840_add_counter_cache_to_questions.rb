class AddCounterCacheToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :unique_views, :integer, default: 0
  end
end
