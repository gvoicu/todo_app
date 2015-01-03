class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :ingredients
      t.integer :grams
      t.float :price
      t.integer :time
      t.references :dish_type

      t.timestamps
    end
    add_index :dishes, :dish_type_id
  end
end
