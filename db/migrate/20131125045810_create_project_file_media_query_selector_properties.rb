class CreateProjectFileMediaQuerySelectorProperties < ActiveRecord::Migration
  def change
    create_table :project_file_media_query_selector_properties do |t|
      t.references :project_file_media_query_selector
      t.string :name
      t.string :value
      t.column :is_important, :tinyint
      t.integer :line
      t.integer :start
      t.timestamps
    end
    add_index :project_file_media_query_selector_properties, :project_file_media_query_selector_id, :name => 'index_properties_on_project_file_media_query_selector_id'
    add_index :project_file_media_query_selector_properties, :name, :name => 'index_properties_on_name'
    add_index :project_file_media_query_selector_properties, :value, :name => 'index_properties_on_value'
    add_index :project_file_media_query_selector_properties, :is_important, :name => 'index_properties_on_is_important'
  end
end
