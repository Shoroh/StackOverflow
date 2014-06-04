class VotesController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :check_permissions, only: :destroy
  respond_to :js
  belongs_to :question, :answer, polymorphic: true
  custom_actions resource: [:like, :unlike]
  actions :destroy

  def like
    parent.like(current_user)
  end

  def unlike
    parent.unlike(current_user)
  end

  protected

  def resource
    @vote ||= end_of_association_chain.find_by(user: current_user)
  end

end
