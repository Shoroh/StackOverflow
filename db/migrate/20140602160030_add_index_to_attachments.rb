class AddIndexToAttachments < ActiveRecord::Migration
  def change
    remove_index :attachments, :attachmentable_id
    add_index :attachments, [:attachmentable_type, :attachmentable_id]
  end
end
