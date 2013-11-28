require 'pp'
class SimilaritiesController < TakiController

  def index
    calc_similarity 1,2
  end

  def show
  end

  private
  def calc_similarity(selector_id_a,selector_id_b)
    properties_a = ProjectFileMediaQuerySelectorProperty.where(project_file_media_query_selector_id: selector_id_a).all
    properties_b = ProjectFileMediaQuerySelectorProperty.where(project_file_media_query_selector_id: selector_id_b).all

    diff = properties_a - properties_b


  end

end
