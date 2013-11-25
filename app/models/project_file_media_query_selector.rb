class ProjectFileMediaQuerySelector < ActiveRecord::Base
  belongs_to :media_query, :class_name => 'ProjectFileMediaQuery', :foreign_key => :project_file_media_query_id

  has_many :project_file_media_query_selector_properties, :as => :properties
  has_many :project_file_media_query_selector_similarities, :as => :similarities
end
