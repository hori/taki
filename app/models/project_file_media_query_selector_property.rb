class ProjectFileMediaQuerySelectorProperty < ActiveRecord::Base
  belongs_to :project_file_media_query_selector, :as => :selector
end
