class AddKarmaPowerToUsers < ActiveRecord::Migration
  def change
    add_column :profiles, :karma_power, :float, default: 1.0
  end
end
