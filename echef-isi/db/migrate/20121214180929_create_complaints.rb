class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :body

      t.timestamps
    end
  end
end
