class JsdocCreateProjectsTable < ActiveRecord::Migration
  def self.up
    create_table :jsdoc_projects do |t|
      t.string :name
      t.string :slug
      t.text :description

      t.timestamps
    end

    add_index :jsdoc_projects, :slug
  end

  def self.down
    drop_table :jsdoc_projects
  end
end
