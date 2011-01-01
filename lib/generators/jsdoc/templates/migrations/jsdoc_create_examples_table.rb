class JsdocCreateExamplesTable < ActiveRecord::Migration
  def self.up
    create_table :jsdoc_examples do |t|
      t.integer :example_for_id
      t.string :example_for_type
      t.text :code

      t.timestamps
    end

    add_index :jsdoc_examples, :example_for_id
    add_index :jsdoc_examples, :example_for_type
  end

  def self.down
    drop_table :jsdoc_examples
  end
end
