class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.timestamp :start
      t.timestamp :end
      t.string :name
      t.string :email
      t.string :phone
      t.boolean :confirmed
      t.references :table

      t.timestamps
    end
    add_index :bookings, :table_id
  end
end
