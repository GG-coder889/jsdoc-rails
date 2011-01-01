class JsdocCreateBorrowedFunctionsTable < ActiveRecord::Migration
  def self.up
    create_table :jsdoc_borrowed_functions do |t|
      t.integer :borrowed_to_id
      t.integer :borrowed_from_id
      t.integer :function_id

      t.timestamps
    end

    add_index :jsdoc_borrowed_functions, :borrowed_from_id
    add_index :jsdoc_borrowed_functions, :borrowed_to_id
    add_index :jsdoc_borrowed_functions, :function_id
  end

  def self.down
    drop_table :jsdoc_borrowed_functions
  end
end
