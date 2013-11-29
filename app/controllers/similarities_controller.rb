class SimilaritiesController < TakiController

  def index
    calc_similarities 1
  end

  def show
  end

  private
  def calc_similarities(file_id)
    similarities = []
    combinations = []

    selector_ids = ProjectFileSelector.where(project_file_id: file_id).pluck(:id)

    selector_ids.each_with_index do |id_a, index|
      for id_b in selector_ids[index+1..-1] do
        combinations << %W|#{id_a} #{id_b}|
      end
    end

    # @todo parallelization
    for selector_ids in combinations do
      match_prop = 0
      match_val = 0
      properties_a = ProjectFileSelectorProperty.where(project_file_selector_id: selector_ids[0]).map(&:serializable_hash)
      properties_b = ProjectFileSelectorProperty.where(project_file_selector_id: selector_ids[1]).map(&:serializable_hash)

      properties_a.each_with_index do |property_a, index_a|
        properties_b.each_with_index do |property_b, index_b|
          if property_a['name'] == property_b['name'] then
            match_prop+=1
            if property_a['value'] == property_b['value'] then
              match_val+=1
            end
          end
        end
      end

      unique_property_count = properties_a.count + properties_b.count - match_prop
      pp match_prop / unique_property_count
      pp match_val / unique_property_count

      similarities << {"combination" => selector_ids,
                      "property_similarity" => match_prop / unique_property_count,
                      "value_similarity" => match_prop / unique_property_count}

    end
    return similarities
  end
end
