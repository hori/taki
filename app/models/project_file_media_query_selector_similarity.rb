class ProjectFileMediaQuerySelectorSimilarity < ActiveRecord::Base
  has_one :current_selector, foreign_key => "current_selector_id", class_name => "ProjectFileMediaQuerySelector"
  has_one :compared_selector, foreign_key => "compared_selector_id", class_name => "ProjectFileMediaQuerySelector"
end
