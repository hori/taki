class CreateProjectFileSelectors < ActiveRecord::Migration
  def change
    create_table :project_file_selectors do |t|
      t.references :project_file
      t.string    :name
      t.integer  :line
      t.integer  :start
      t.text    :raw
      t.timestamps
    end
    add_index :project_file_selectors, :project_file_id, :name => 'index_selectors_on_project_file_id'

    # TODO: heroku clearDB doesn't support FULLTEXT indexes.
    # add_index :project_file_selectors, :name, :name => 'index_selectors_on_name', type: :fulltext
  end
end
