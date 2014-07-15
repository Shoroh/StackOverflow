class Api::V1::BaseController < InheritedResources::Base
  protect_from_forgery with: :null_session
  doorkeeper_for :all
  layout false
  serialization_scope :current_resource_owner

  def current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

end

