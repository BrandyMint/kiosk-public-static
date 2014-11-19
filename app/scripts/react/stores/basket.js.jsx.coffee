_basketItems = {}

addToBasket = (data)->
  console.log 'store add to cart'
  console.log data
  _basketItems[data.order_product_id] =
    productItem: data
  return

window.BasketDispatcher.register (payload) ->
  action = payload.action
  
  switch action.actionType
    when 'addToBasket'
      addToBasket action.data
      break

window.basketStore = assign({}, EventEmitter::,
  
  getBasketItems: ->
    _basketItems

  getBasketCount: ->
    Object.keys(_basketItems).length
)