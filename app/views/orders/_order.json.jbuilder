json.extract! order, :id, :product_id, :buyer_id, :seller_id, :created_at, :updated_at
json.url order_url(order, format: :json)
