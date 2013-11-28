class CreateProjectFiles < ActiveRecord::Migration
  def change
    create_table :project_files do |t|
      t.attachment :attachment
      t.string   :status
      t.timestamps
    end

    create_table :project_file_selectors do |t|
      t.references :project_file
      t.text    :name
      t.text    :raw
      t.integer  :line
      t.integer  :start
      t.timestamps
    end

    create_table :project_file_media_queries do |t|
      t.references :project_file
      t.references :project_file_selector
      t.string   :name
      t.timestamps
    end

    create_table :project_file_selector_properties do |t|
      t.references :project_file_selector
      t.string :name
      t.string :value
      t.column :is_important, :tinyint
      t.integer :line
      t.integer :start
      t.timestamps
    end

    create_table :project_file_selector_similarities do |t|
      t.integer :current_selector_id, references: :project_file_selector
      t.integer :compared_selector_id, references: :project_file_selector
      t.float :property
      t.float :value
      t.timestamps
    end

    add_index :project_files                     , :status                                      , :name => 'index_project_files_on_status'
    # TODO: heroku clearDB doesn't support FULLTEXT indexes.
    # add_index :project_file_selectors           , :name                                        , :name => 'index_selectors_on_name'                        , type: :fulltext
    add_index :project_file_selectors            , :project_file_id                             , :name => 'index_selectors_on_project_file_id'
    add_index :project_file_media_queries        , :project_file_id                             , :name => 'index_media_queries_on_project_file_id'
    add_index :project_file_media_queries        , :project_file_selector_id                    , :name => 'index_media_queries_on_project_file_selector_id', :unique => true
    add_index :project_file_selector_properties  , :project_file_selector_id                    , :name => 'index_properties_on_project_file_selector_id'
    add_index :project_file_selector_properties  , :name                                        , :name => 'index_properties_on_name'
    add_index :project_file_selector_properties  , :value                                       , :name => 'index_properties_on_value'
    add_index :project_file_selector_properties  , :is_important                                , :name => 'index_properties_on_is_important'
    add_index :project_file_selector_similarities, :current_selector_id                         , :name => 'index_similarities_on_current_selector_id'
    add_index :project_file_selector_similarities, :compared_selector_id                        , :name => 'index_similarities_on_compared_selector_id'
    add_index :project_file_selector_similarities, [:current_selector_id, :compared_selector_id], :name => 'index_similarities_on_selector_ids'             , :unique => true

  end
end
