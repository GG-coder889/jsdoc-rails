class JsdocCreateVersionsTable < ActiveRecord::Migration
  def self.up
    create_table :jsdoc_versions do |t|
      t.integer :project_id
      t.string :version_number
      t.text :description

      t.timestamps
    end

    add_index :jsdoc_versions, [:project_id, :version_number]
  end

  def self.down
    drop_table :jsdoc_versions
  end
end
