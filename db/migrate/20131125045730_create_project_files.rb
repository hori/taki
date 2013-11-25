class CreateProjectFiles < ActiveRecord::Migration
  def change
    create_table :project_files do |t|
      t.attachment :attachment
      t.string   :status
      t.timestamps
    end
    add_index :project_files, :status, :name => 'index_project_files_on_status'
  end
end
