class JsdocAddVersionReferenceToSymbols < ActiveRecord::Migration
  def self.up
    add_column :jsdoc_symbols, :version_id, :integer
    add_index  :jsdoc_symbols, :version_id
  end

  def self.down
    remove_index  :jsdoc_symbols, :column => :version_id
    remove_column :jsdoc_symbols, :version_id
  end
end
