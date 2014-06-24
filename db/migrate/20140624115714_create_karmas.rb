class CreateKarmas < ActiveRecord::Migration
  def change
    create_table :karmas do |t|
      t.references :user, index: true
      t.references :karmable, :polymorphic => true
      t.integer :score
      t.string :action

      t.timestamps
    end
    add_index :karmas, [:karmable_id, :karmable_type]
  end
end
