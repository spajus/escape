class CreateChars < ActiveRecord::Migration
  def change
    create_table :chars do |t|
      t.column :name, 'char(20)'
      t.string :pass, null: false
      t.datetime :last_seen_at, null: false
      t.column :x, :integer, null: false
      t.column :y, :integer, null: false
      t.column :z, :integer, default: 0
      t.timestamps
    end

    add_index :chars, :name, unique: true
    add_index :chars, [:x, :y, :z]
  end
end
