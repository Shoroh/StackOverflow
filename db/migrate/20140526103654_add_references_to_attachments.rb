class AddReferencesToAttachments < ActiveRecord::Migration
  def change
    add_reference :attachments, :user, index: true
  end
end
