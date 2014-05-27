class CreateClips < ActiveRecord::Migration
  def change
    create_table :clips do |t|
      t.integer  :answer_id
      t.string   :file

      t.timestamps
    end
  end
end
