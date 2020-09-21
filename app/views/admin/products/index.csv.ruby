require "csv"

column_names = %w(category_name title price user_name created_at updated_at)

CSV.generate(headers: true) do |csv|
  csv << column_names
  @products.each do |product|
    csv << column_names.map {|attr| product.send(attr)}
  end
end
