module Admin::ProductsHelper
  def number_to_vnd(number)
    number_to_currency(number, unit: "₫", separator: ".", delimiter: ",", format: "%n %u", precision: 0)
  end
end
