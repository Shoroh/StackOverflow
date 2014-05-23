# Registered users.
class User < ActiveRecord::Base
  TEMP_EMAIL = 'change@me.com'
  TEMP_EMAIL_REGEX = /change@me.com/

  has_many :questions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_one :profile, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]

  validates_format_of :email, without: TEMP_EMAIL_REGEX, on: :update
  validates :name, uniqueness: true, presence: true, length: 3..90

  after_create :set_profile

  delegate :age, :facebook_id, :display_name, to: :profile

  def nick
    self.profile.display_name.presence || self.name
  end

  private

  def set_profile
    self.create_profile
  end

  def self.find_for_oauth(auth, signed_in_resource = nil)
    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)
    user = identity.user ? identity.user : signed_in_resource

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the OAuth provider gives us a verified email
      # If the email has not been verified yet we will force the user to validate it
      email = auth.info.email if auth.info.email
      user = User.where(email: email).first if email

      # Create the user if it is a new registration
      if user.nil?
        user = User.new(
            name: auth.extra.raw_info.name,
            # username: auth.info.nickname || auth.uid,
            email: email ? email : TEMP_EMAIL,
            password: Devise.friendly_token[0, 20]
        )
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end
end
