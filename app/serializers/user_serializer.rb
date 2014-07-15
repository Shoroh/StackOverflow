class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at
  has_one :profile

  def attributes
    data = super
    data[:email] = object.email if object.email == scope.email
    data
  end
end
