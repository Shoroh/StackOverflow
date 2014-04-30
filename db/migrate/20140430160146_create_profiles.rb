class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :age
      t.string :display_name
      t.string :facebook_id

      t.integer :user_id, null: false

      t.timestamps
    end
    add_index :profiles, :user_id
  end
end
