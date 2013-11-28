class ProjectFileMediaQuery < ActiveRecord::Base
  attr_accessible :project_file_selector_id, :name

  belongs_to :project_file
  has_many :project_file_selectors
end
