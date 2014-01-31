class ProjectFileSelectorProperty < ActiveRecord::Base
  attr_accessible :name, :value, :is_important, :line, :start
  belongs_to :project_file_selector

  after_commit :similar, :on => [:create, :update]

  def similar
    # TODO: similarities updated
  end
end
