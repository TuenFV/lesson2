require 'csv'

class Product < ApplicationRecord
  belongs_to :category

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  def self.to_csv
    attributes = %w{id name description product_category stock price}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |product|
        csv << attributes.map { |attr| product.send(attr) } 
      end
    end
  end

  def self.import_file(file)
    products = []

    CSV.foreach(file.path, headers: true) do |row|
      category = Category.find_by(name: row.to_h["product_category"])
      
      until category do
        category_new = { name: row.to_h["product_category"], description: 'TBD' }
        category = Category.create(category_new)
      end
      product = Product.new(row.to_h)
      product.category_id = category.id
      products << product
    end
    Product.import(products)
  end
end
