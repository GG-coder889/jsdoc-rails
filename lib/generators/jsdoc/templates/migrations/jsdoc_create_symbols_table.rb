class JsdocCreateSymbolsTable < ActiveRecord::Migration
  def self.up
    create_table :jsdoc_symbols do |t|
      t.string :name
      t.string :alias
      t.string :member_of
      t.integer :constructor_id
      t.string :symbol_type
      t.string :version
      t.text :description
      t.string :defined_in
      t.string :since
      t.string :author
      t.string :extends
      t.boolean :is_deprecated
      t.text :deprecated_description

      t.timestamps
    end

    add_index :jsdoc_symbols, :name
    add_index :jsdoc_symbols, :alias
    add_index :jsdoc_symbols, :member_of
    add_index :jsdoc_symbols, :symbol_type
    add_index :jsdoc_symbols, :constructor_id
  end

  def self.down
    drop_table :jsdoc_symbols
  end
end
