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
end
