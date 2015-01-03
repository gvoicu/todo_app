class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.integer :number
      t.string :qr_code
      t.integer :persons

      t.timestamps
    end
  end
end
