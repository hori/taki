class ProjectFilesController < TakiController
  before_action :set_project_file, only: [:show, :z_index, :similarity]

  # GET /
  def top
    @project_file = ProjectFile.new
  end

  def create
    @project_file = ProjectFile.create( file_params )
    redirect_to project_file_url(@project_file)
  end

  # GET /project_files
  # GET /project_files.json
  def index
    @project_files  = ProjectFile.limit(5).order(created_at: :desc)
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
    # @simirarities = @project_file.calc_similarities
    # simirarities = ProjectFileSelector.includes(:project_file_selector_similarities).references(:property)
    similarities = ProjectFileSelector.where(project_file_id: @project_file.id).map(&:project_file_selector_similarities)
    render :json => similarities.page(1).par(10)
  end

  private
  def set_project_file
    @project_file = ProjectFile.find(params[:id])
    raise ActiveRecord::RecordNotFound if @project_file.blank?
  end

  def file_params
      params.require(:project_file).permit(:attachment)
  end

end
