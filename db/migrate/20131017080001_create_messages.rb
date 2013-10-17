class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.column :kind, 'smallint(4)', default: 0
      t.column :author_id, :integer, null: false
      t.column :receiver_id, :integer
      t.column :content, 'varchar(140)'
      t.timestamps
    end

    add_index :messages, :created_at
  end
end
