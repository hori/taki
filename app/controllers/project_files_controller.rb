class ProjectFilesController < TakiController
  before_action :set_project_file, only: [:show, :z_index, :similarity]

  # GET /
  def index
    @project_file = ProjectFile.new
  end

  def create
    @project_file = ProjectFile.create( file_params )
    redirect_to project_file_url(@project_file)
  end

  # GET /project_files/:id
  # GET /project_files/:id.json
  def show
    selector_ids = @project_file.project_file_selectors.pluck(:id)
    @properties  = ProjectFileSelectorProperty.where(project_file_selector_id: selector_ids)
  end

  # GET /project_files/:id/z-index
  # GET /project_files/:id/z-index.json
  def z_index
    selector_ids = @project_file.project_file_selectors.pluck(:id)
    @properties = ProjectFileSelectorProperty.where({ name: 'z-index', project_file_selector_id: selector_ids}).order(value: :desc)
    @properties.sort! {|a, b| a.value.to_i <=> b.value.to_i }
  end

  # GET /project_files/:id/similarity
  # GET /project_files/:id/similarity.json
  def similarity
    @simirarities = calc_similarities(@project_file.id)
  end

  private
  def set_project_file
    @project_file = ProjectFile.find(params[:id])
    raise ActiveRecord::RecordNotFound if @project_file.blank?
  end

  def file_params
      params.require(:project_file).permit(:attachment)
  end

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

      similarities << {:combination => selector_ids,
                       :property_similarity => (match_prop.to_f / unique_property_count.to_f),
                       :value_similarity => (match_prop.to_f / unique_property_count.to_f)}

    end
    similarities
  end
end
