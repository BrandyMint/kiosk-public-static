BaseStore = require './_base'

_basketItems = {}

addToBasket = (productItem)->
  _basketItems[productItem.product_item_id] =
    productItem: productItem
  return

window.BasketDispatcher.register (payload) ->
  action = payload.action
  
  switch action.actionType
    when 'addToBasket'
      addToBasket action.productItem
      break

window.basketStore = _.extend new BaseStore(), {
  
  getBasketItems: ->
    _basketItems

  getBasketCount: ->
    Object.keys(_basketItems).length
}