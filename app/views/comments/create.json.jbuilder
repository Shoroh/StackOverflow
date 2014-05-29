if @comment.errors.any?
  json.errors @comment.errors.full_messages.first
  json.commentable_type @comment.commentable_type
  json.commentable_id @comment.commentable_id
else
  json.comment do
    json.id @comment.id
    json.body @comment.body
    json.created_at @comment.created_at.to_formatted_s(:short)
    json.commentable_type @comment.commentable_type
    json.commentable_id @comment.commentable_id
  end

  json.counts pluralize(@comment.commentable.comments.count, 'comment')
  json.user @comment.user, :id, :name
end

