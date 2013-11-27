class ProjectFile < ActiveRecord::Base
  attr_accessible :attachment
  has_many :project_file_media_queries, :as => :media_queries

  has_attached_file :attachment

  validates_attachment :attachment, presence: true,
    content_type: { content_type: ["text/css"] },
    size: { less_than: 10.megabytes }

  def attachment_contents
    attachment.copy_to_local_file.read
  end
end
