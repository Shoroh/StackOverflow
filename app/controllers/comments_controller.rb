class CommentsController < InheritedResources::Base
  respond_to :js
  before_action :authenticate_user!
  before_action except: :create do
    check_permissions(resource)
  end
  actions :all, except: :new
  belongs_to :answer, :question, polymorphic: true

  protected

  def create_resource(object)
    object.user = current_user
    super
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

end
