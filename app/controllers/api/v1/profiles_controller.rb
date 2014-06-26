class Api::V1::ProfilesController < Api::V1::BaseController
  respond_to :json

  def me
    respond_with current_resource_owner
  end

  def all
    respond_with User.all.to_json(except: [:admin, :email])
  end

end