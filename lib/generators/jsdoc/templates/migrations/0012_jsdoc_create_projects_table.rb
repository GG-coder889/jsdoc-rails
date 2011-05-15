class JsdocCreateProjectsTable < ActiveRecord::Migration
  def self.up
    create_table :jsdoc_projects do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :jsdoc_projects
  end
end
