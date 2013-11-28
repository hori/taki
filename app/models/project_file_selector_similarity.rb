class ProjectFileSelectorSimilarity < ActiveRecord::Base
  belongs_to :current_selector, :foreign_key => "current_selector_id", :class_name => "ProjectFileSelector"
  belongs_to :compared_selector, :foreign_key => "compared_selector_id", :class_name => "ProjectFileSelector"

  has_many :project_file_selectors
end
