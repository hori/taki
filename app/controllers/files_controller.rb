class FilesController < TakiController
  before_action :set_project_file, only: [:show, :z_index]

  # GET /
  def index
  end

  # GET /files/:id
  # GET /files/:id.json
  def show
    raise ActiveRecord::RecordNotFound if @project_file.blank?
  end

  # GET /files/:id/z-indexes
  # GET /files/:id/z-indexes.json
  def z_index
    raise ActiveRecord::RecordNotFound if @project_file.blank?
  end

  private
  def set_project_file
    @project_file = ProjectFile.find(params[:id])
  end
end
