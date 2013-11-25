class CreateProjectFileMediaQuerySelectorSimilarities < ActiveRecord::Migration
  def change
    create_table :project_file_media_query_selector_similarities do |t|
      t.integer :current_selector_id, references: :project_file_media_query_selector
      t.integer :compared_selector_id, references: :project_file_media_query_selector
      t.float :property
      t.float :value
      t.timestamps
    end
    add_index :project_file_media_query_selector_similarities, [:current_selector_id, :compared_selector_id], :unique => true, :name => 'index_similarities_on_selector_ids'
    add_index :project_file_media_query_selector_similarities, :current_selector_id, :name => 'index_similarities_on_current_selector_id'
    add_index :project_file_media_query_selector_similarities, :compared_selector_id, :name => 'index_similarities_on_compared_selector_id'
  end
end
