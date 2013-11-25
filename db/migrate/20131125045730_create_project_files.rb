class CreateProjectFiles < ActiveRecord::Migration
  def change
    create_table :project_files do |t|
      t.string   :path
      t.string   :extension
      t.string   :status
      t.timestamps
    end
    add_index :project_files, :path, :unique => true, :name => 'index_project_files_on_path'
    add_index :project_files, :extension, :name => 'index_project_files_on_extension'
    add_index :project_files, :status, :name => 'index_project_files_on_status'
  end
end
