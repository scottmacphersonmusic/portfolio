class Project < ActiveRecord::Base
  validates :technologies_used, presence: true
  validates :name, length: { in: 2..255 }
end
