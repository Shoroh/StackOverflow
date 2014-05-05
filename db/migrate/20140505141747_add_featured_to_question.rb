class AddFeaturedToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :featured, :boolean
  end
end
