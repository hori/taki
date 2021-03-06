class ProjectFileSelector < ActiveRecord::Base
  attr_accessible :name, :line, :start, :raw

  belongs_to :project_file
  belongs_to :project_file_media_query

  has_many :project_file_selector_properties
  has_many :project_file_selector_similarities
end
