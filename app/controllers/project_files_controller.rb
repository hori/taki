class ProjectFilesController < TakiController
  before_action :set_project_file, only: [:show, :z_index]

  # GET /
  def index
    @project_file = ProjectFile.new
  end

  def create
    @project_file = ProjectFile.create( file_params )
    redirect_to project_file_url(@project_file)
  end

  # GET /files/:id
  # GET /files/:id.json
  def show
  end

  # GET /files/:id/z-indexes
  # GET /files/:id/z-indexes.json
  def z_index
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
