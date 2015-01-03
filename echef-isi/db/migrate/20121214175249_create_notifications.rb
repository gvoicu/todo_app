class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :note
      t.references :table

      t.timestamps
    end
    add_index :notifications, :table_id
  end
end
