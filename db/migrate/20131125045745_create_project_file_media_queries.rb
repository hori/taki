class CreateProjectFileMediaQueries < ActiveRecord::Migration
  def change
    create_table :project_file_media_queries do |t|
      t.references :project_file
      t.text   :raw
      t.timestamps
    end
    add_index :project_file_media_queries, :project_file_id, :name => 'index_media_queries_on_project_file_id'
  end
end