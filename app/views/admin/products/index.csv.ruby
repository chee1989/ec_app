require "csv"

column_names = %w(id category_name title price user_name)

CSV.generate(headers: true) do |csv|
  csv << I18n.t(column_names, scope: [:csv, :header, :product])
  @products.each do |product|
    csv << column_names.map {|attr| product.send(attr)}
  end
end
