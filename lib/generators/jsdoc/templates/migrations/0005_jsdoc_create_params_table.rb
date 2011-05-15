class JsdocCreateParamsTable < ActiveRecord::Migration
  def self.up
    create_table :jsdoc_params do |t|
      t.integer :function_id
      t.integer :order
      t.string :name
      t.string :default
      t.boolean :is_optional
      t.string :param_type
      t.text :description

      t.timestamps
    end

    add_index :jsdoc_params, :function_id
    add_index :jsdoc_params, :name
    add_index :jsdoc_params, :order
    add_index :jsdoc_params, :param_type
  end

  def self.down
    drop_table :jsdoc_params
  end
end
