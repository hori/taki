class ProjectFileMediaQuerySelector < ActiveRecord::Base
  belongs_to :project_file_media_query, :as => :media_query

  has_many :project_file_media_query_selector_properties, :as => :properties
  has_many :project_file_media_query_selector_similarities, :as => :similarities
end
