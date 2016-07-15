class User < ActiveRecord::Base
  enum role: [:normal, :admin]
  after_initialize :set_default_role, :if => :new_record?
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:google_oauth2, :facebook]
  has_many :diaries
  has_many :albums
  has_many :orders
  
  
  def set_default_role
    self.role ||= :normal
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
      user.skip_confirmation!
      user.save!
    end
  end
  
=begin
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(name: data["name"],
        email: data["email"],
        password: Devise.friendly_token[0,20]
        )
    end
    user
  end
=end


end
