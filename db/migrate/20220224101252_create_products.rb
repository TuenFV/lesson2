class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text   :description
      t.text   :product_category
      t.integer :stock
      t.decimal :price

      t.timestamps
    end
  end
end
