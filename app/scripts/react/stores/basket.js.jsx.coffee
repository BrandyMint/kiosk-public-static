_items = {}

addToBasket = (data)->
  console.log 'store add to cart'
  console.log data
  _items[data.order_product_id] =
    product_item_id: data.order_product_id
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
    when 'addToBasket'
      addToBasket action.data
      break