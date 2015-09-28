class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  validates :commenter_name, :commenter_email, :content, presence: true
end
