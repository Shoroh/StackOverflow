class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :votable, :polymorphic => true
      t.references :user, index: true
      t.integer :value

      t.boolean :vote_flag

      t.timestamps
    end

    add_index :votes, [:votable_id, :votable_type]

  end
end
