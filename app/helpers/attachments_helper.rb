module AttachmentsHelper

  def attachment_links_edit(attachment)

    content_tag(:li, id: "edit-attachment-#{attachment.id}") do
      raw(
      link_to(attachment.file.filename, attachment.file.url) +
      " | " +
      number_to_human_size(attachment.file.size) +
      " | " +
      link_to('Remove this file', attachment_path(attachment), method: :delete, remote: true)
      )
    end

  end

end