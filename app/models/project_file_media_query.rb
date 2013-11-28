class ProjectFileMediaQuery < ActiveRecord::Base
  belongs_to :project_file
  has_many :project_file_selectors
end
