class AddCategoryIdToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :categoty_id, :integer
    add_index :products, :categoty_id
  end
end
