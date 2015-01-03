class AddNameToDishes < ActiveRecord::Migration
  def change
    add_column :dishes, :name, :string
  end
end
