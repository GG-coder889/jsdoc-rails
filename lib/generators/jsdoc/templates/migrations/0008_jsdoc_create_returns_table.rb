class JsdocCreateReturnsTable < ActiveRecord::Migration
  def self.up
    create_table :jsdoc_returns do |t|
      t.integer :function_id
      t.string :return_type
      t.text :description

      t.timestamps
    end

    add_index :jsdoc_returns, :function_id
    add_index :jsdoc_returns, :return_type
  end

  def self.down
    drop_table :jsdoc_returns
  end
end
