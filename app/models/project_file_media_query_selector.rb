class ProjectFileMediaQuerySelector < ActiveRecord::Base
  belongs_to :project_file_media_query

  has_many :project_file_media_query_selector_properties
  has_many :project_file_media_query_selector_similarities
end
