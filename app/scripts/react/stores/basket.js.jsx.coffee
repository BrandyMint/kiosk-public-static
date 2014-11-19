_products = {}

addToCart = (data)->
  console.log 'store add to cart'
  console.log data
  _products[data.order_product_id] =
    order_product_id: data.order_product_id
    product_id: data.product_id
    price: data.price
    count: data.count
    image_url: data.image_url
    title: data.title
    description: data.description
  return

window.BasketDispatcher.register (payload) ->
  action = payload.action
  
  switch action.actionType
    when 'addToCart'
      addToCart action.data
      break