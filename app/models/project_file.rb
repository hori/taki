class ProjectFile < ActiveRecord::Base
  has_many :project_file_media_queries, :as => :media_queries

  has_attached_file :attachment

  def attachment_contents
    attachment.copy_to_local_file.read
  end
end
