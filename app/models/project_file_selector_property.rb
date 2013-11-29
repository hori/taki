class ProjectFileSelectorProperty < ActiveRecord::Base
  attr_accessible :name, :value, :is_important, :line, :start
  belongs_to :project_file_selector
end
