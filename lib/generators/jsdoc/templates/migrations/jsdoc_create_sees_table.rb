class JsdocCreateSeesTable < ActiveRecord::Migration
  def self.up
    create_table :jsdoc_sees do |t|
      t.integer :see_for_id
      t.string :see_for_type
      t.text :description

      t.timestamps
    end

    add_index :jsdoc_sees, :see_for_id
    add_index :jsdoc_sees, :see_for_type
  end

  def self.down
    drop_table :jsdoc_sees
  end
end
