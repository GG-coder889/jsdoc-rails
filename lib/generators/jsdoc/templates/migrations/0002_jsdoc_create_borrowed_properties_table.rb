class JsdocCreateBorrowedPropertiesTable < ActiveRecord::Migration
  def self.up
    create_table :jsdoc_borrowed_properties do |t|
      t.integer :borrowed_to_id
      t.integer :borrowed_from_id
      t.integer :property_id

      t.timestamps
    end

    add_index :jsdoc_borrowed_properties, :borrowed_from_id
    add_index :jsdoc_borrowed_properties, :borrowed_to_id
    add_index :jsdoc_borrowed_properties, :property_id
  end

  def self.down
    drop_table :jsdoc_borrowed_properties
  end
end
