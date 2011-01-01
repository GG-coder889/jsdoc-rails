class JsdocCreatePropertiesTable < ActiveRecord::Migration
  def self.up
    create_table :jsdoc_properties do |t|
      t.string :name
      t.string :alias
      t.string :member_of
      t.integer :symbol_id
      t.string :property_type
      t.string :version
      t.text :description
      t.string :defined_in
      t.string :since
      t.string :author
      t.string :default
      t.boolean :is_private
      t.boolean :is_inner
      t.boolean :is_static
      t.boolean :is_constant
      t.boolean :is_deprecated
      t.text :deprecated_description

      t.timestamps
    end

    add_index :jsdoc_properties, :symbol_id
    add_index :jsdoc_properties, :property_type
    add_index :jsdoc_properties, :name
    add_index :jsdoc_properties, :alias
    add_index :jsdoc_properties, :member_of
  end

  def self.down
    drop_table :jsdoc_properties
  end
end
