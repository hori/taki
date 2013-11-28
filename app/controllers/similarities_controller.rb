class SimilaritiesController < TakiController

  def index
    calc_similarities 3
    #calc_similarity 1,2
  end

  def show
  end

  private
  def calc_similarity(selector_id_a,selector_id_b)
    properties_a = ProjectFileSelectorProperty.where(project_file_selector_id: selector_id_a).all
    properties_b = ProjectFileSelectorProperty.where(project_file_selector_id: selector_id_b).all

    diff = properties_a - properties_b


  end

  def calc_similarities(file_id)
    selector_ids = ProjectFileSelector.where(project_file_id: file_id).pluck(:id)
    combinations = []
    selector_ids.each_with_index do |id_a, index|
      for id_b in selector_ids[index+1..-1] do
        combinations << %W|#{id_a} #{id_b}|
      end
    end

    # @todo parallelization
    for selector_ids in combinations do
      properties_a = ProjectFileSelectorProperty.where(project_file_selector_id: selector_ids[0])
      properties_b = ProjectFileSelectorProperty.where(project_file_selector_id: selector_ids[1])
    end
  end

end
