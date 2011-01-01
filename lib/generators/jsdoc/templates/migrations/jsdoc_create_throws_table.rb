class JsdocCreateThrowsTable < ActiveRecord::Migration
  def self.up
    create_table :jsdoc_throws do |t|
      t.integer :function_id
      t.string :throw_type
      t.text :description

      t.timestamps
    end

    add_index :jsdoc_throws, :function_id
    add_index :jsdoc_throws, :throw_type
  end

  def self.down
    drop_table :jsdoc_throws
  end
end
