class JsdocCreateRequiresTable < ActiveRecord::Migration
  def self.up
    create_table :jsdoc_requires do |t|
      t.integer :function_id
      t.text :require

      t.timestamps
    end

    add_index :jsdoc_requires, :function_id
  end

  def self.down
    drop_table :jsdoc_requires
  end
end
