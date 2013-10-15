class CreateCells < ActiveRecord::Migration
  def change
    create_table :cells do |t|
      t.column :x, :integer, null: false
      t.column :y, :integer, null: false
      t.column :z, :integer, default: 0
      t.column :kind, 'smallint(4)', default: 0
      t.column :creator_id, :integer
      t.column :desc, 'varchar(140)'
      t.timestamps
    end

    add_index :cells, [:x, :y, :z], unique: true
  end
end
