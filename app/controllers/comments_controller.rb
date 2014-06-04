class CommentsController < InheritedResources::Base
  respond_to :js
  before_action :authenticate_user!
  before_action :set_commentable, only: :create
  before_action :set_comment, except: :create
  before_action except: :create do
    check_permissions(@comment)
  end
  actions :all, except: :new
  belongs_to :answers, :questions, optional: true

  def create
    @comment = Comment.create(comment_params, @commentable, current_user)
  end

  def update
    @comment.update(comment_params)
  end

  private

  def set_comment
    @comment ||= Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_commentable
    @commentable = params[:commentable_type].classify.constantize.find(params[:commentable_id])
  end

end
