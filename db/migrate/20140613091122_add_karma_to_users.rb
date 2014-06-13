class AddKarmaToUsers < ActiveRecord::Migration
  def change
    add_column :profiles, :karma, :integer, default: 0
  end
end
