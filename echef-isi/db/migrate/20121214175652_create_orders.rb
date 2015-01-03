class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.timestamp :closed_at
      t.integer :rating
      t.references :table

			t.integer	:waiter_id
			t.integer	:chef_id

      t.timestamps
    end
    add_index :orders, :table_id
		add_index :orders, :waiter_id
		add_index	:orders, :chef_id
  end
end
