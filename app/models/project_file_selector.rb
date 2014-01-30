class ProjectFileSelector < ActiveRecord::Base
  attr_accessible :name, :line, :start, :raw

  belongs_to :project_file
  belongs_to :project_file_media_query

  has_many :project_file_selector_properties
  has_many :project_file_selector_similarities, :foreign_key => 'current_selector_id'
  has_many :project_file_selector_similarities_compared, :foreign_key => 'compared_selector_id', :class_name => "ProjectFileSelectorSimilarity"
end
