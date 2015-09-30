class Project < ActiveRecord::Base
  has_many :comments, as: :commentable

  validates :technologies_used, presence: true
  validates :name, length: { in: 2..255 }

  mount_uploader :logo, ProfileLogoUploader
end
