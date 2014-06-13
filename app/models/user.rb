# Registered users.
class User < ActiveRecord::Base
  TEMP_EMAIL = 'change@me.com'
  TEMP_EMAIL_REGEX = /change@me.com/

  attr_accessor :login

  has_many :attachments, dependent: :destroy
  has_many :identities, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_many :votes, dependent: :destroy



  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         omniauth_providers: [:facebook, :twitter],
         authentication_keys: [:login]

  validates :email, format: {without: TEMP_EMAIL_REGEX, on: :update}
  validates :name, uniqueness: {case_sensitive: false}, presence: true, length: 3..90

  after_create :set_profile

  delegate :age, :facebook_id, :display_name, :karma, to: :profile

  def nick
    profile.display_name.presence || name
  end

  def has_not_email?
    !self.email || self.email == User::TEMP_EMAIL
  end

  def login=(login)
    @login = login
  end

  def login
    @login || self.name || self.email
  end

  private

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end


  def set_profile
    self.create_profile
  end

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)
    user = identity.user ? identity.user : signed_in_resource

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email
      # If the email has not been verified by the provider we will assign the
      # TEMP_EMAIL and get the user to verify it via UsersController.add_email
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(email: email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
            name: auth.info.fetch(:nickname) { (auth.info.name).delete(' ') },
            #username: auth.info.nickname || auth.uid,
            email: email ? email : TEMP_EMAIL,
            password: Devise.friendly_token[0,20]
        )
        #user.skip_confirmation!
        user.save!

        user.profile.display_name = auth.info.name
        user.profile.facebook_id = auth.extra.raw_info.link
        user.profile.save
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
