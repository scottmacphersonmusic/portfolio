class Comment < ActiveRecord::Base
  belongs_to :article

  validates :commenter_name, :commenter_email, :content, presence: true
end
