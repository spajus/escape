class CreateChars < ActiveRecord::Migration
  def change
    create_table :chars do |t|
      t.column :name, 'char(20)'
      t.string :pass
      t.datetime :last_seen_at
      t.column :x, :integer, null: false
      t.column :y, :integer, null: false
      t.column :z, :integer, default: 0
      t.timestamps
    end
  end
end
