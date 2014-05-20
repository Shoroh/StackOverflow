class User < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_one :profile, dependent: :destroy


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]

  validates :name, uniqueness: true, presence: true, length: 3..60


  after_create :set_profile

  delegate :age, :facebook_id, :display_name, to: :profile




  def nick
    self.profile.display_name.presence || self.name
  end

  private

  def set_profile
    self.create_profile

    # TODO Почему не присваивается?
    self.profile.facebook_id = @urls || 'asddadasd'
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        @urls = auth.info.urls
        user = User.create(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20],
                           avatar: auth.info.image
        )
      end

    end
  end


  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)

    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.uid + "@twitter.com").first
      if registered_user
        return registered_user
      else
        user = User.create(name:auth.info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.uid+"@twitter.com",
                           password:Devise.friendly_token[0,20],
                           avatar: auth.info.image
        )
      end
    end
  end
end
