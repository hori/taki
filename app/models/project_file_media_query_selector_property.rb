class ProjectFileMediaQuerySelectorProperty < ActiveRecord::Base
  belongs_to :selector, :class_name => 'ProjectFileMediaQuerySelector', :foreign_key => :project_file_media_query_selector_id
end
