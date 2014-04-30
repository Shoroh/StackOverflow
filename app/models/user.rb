class User < ActiveRecord::Base
  has_many :questions
  has_one :profile
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, :uniqueness => true
  validates :name, :presence => true

  after_create :set_profile



  private

  def set_profile
    self.build_profile
  end
end
