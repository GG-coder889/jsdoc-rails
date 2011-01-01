class JsdocCreateFunctionsTable < ActiveRecord::Migration
  def self.up
    create_table :jsdoc_functions do |t|
      t.string :name
      t.string :alias
      t.string :member_of
      t.integer :symbol_id
      t.string :function_type
      t.string :version
      t.text :description
      t.string :defined_in
      t.string :since
      t.string :author
      t.boolean :is_private
      t.boolean :is_inner
      t.boolean :is_static
      t.boolean :is_deprecated
      t.text :deprecated_description

      t.timestamps
    end

    add_index :jsdoc_functions, :symbol_id
    add_index :jsdoc_functions, :function_type
    add_index :jsdoc_functions, :name
    add_index :jsdoc_functions, :alias
    add_index :jsdoc_functions, :member_of
  end

  def self.down
    drop_table :jsdoc_functions
  end
end
