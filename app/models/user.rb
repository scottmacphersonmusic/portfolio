class User < ActiveRecord::Base
  has_many :articles, foreign_key: "author_id"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  def author?
    role == "author"
  end

  def editor?
    role == "editor"
  end

  def self.from_omniauth(auth)
    auth_search = { email: auth.info.email }

    where(auth_search).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
      user.email = auth.info.email
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end

class NullUser
  def author?
    false
  end

  def editor?
    false
  end

  def id
    false
  end
end
