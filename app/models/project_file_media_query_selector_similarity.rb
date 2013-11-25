class ProjectFileMediaQuerySelectorSimilarity < ActiveRecord::Base
  has_many :project_file_media_query_selectors, :as => :selectors

  belongs_to :current_selector, :foreign_key => "current_selector_id", :class_name => "ProjectFileMediaQuerySelector"
  belongs_to :compared_selector, :foreign_key => "compared_selector_id", :class_name => "ProjectFileMediaQuerySelector"
end
