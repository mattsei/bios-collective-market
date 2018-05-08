json.extract! product, :id, :name, :product_id, :price, :stock, :owner, :description, :created_at, :updated_at
json.url product_url(product, format: :json)
