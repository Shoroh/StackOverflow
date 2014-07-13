class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :created_at, :updated_at
  has_one :profile

  def attributes
    data = super
    # data[:email] = object.email if object == current_user
    # data[:email] = object.email if scope.admin? || object == current_user TODO Не работает!
    data
  end
end
