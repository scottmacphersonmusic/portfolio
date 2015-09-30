class Project < ActiveRecord::Base
  has_many :comments, as: :commentable

  validates :technologies_used, presence: true
  validates :name, length: { in: 2..255 }

  mount_uploader :logo, LogoUploader

  after_save :enqueue_logo

  def logo_name
    File.basename(logo.path || logo.filename) if logo
  end

  def enqueue_logo
    ImageWorker.perform_async(id, key) if key.present?
  end

  class ImageWorker
    include Sidekiq::Worker

    def perform(id, key)
      project = Project.find(id)
      logger.info "\n\n project.inspect: * * * * * #{project.inspect} * * * * * \n\n"
      project.key = key
      project.remote_logo_url = project.logo.direct_fog_url(with_path: true)
      project.save!
      # project.update(key: key,
      #                remote_logo_url: project.logo.direct_fog_url(with_path: true))
    end
  end
end
