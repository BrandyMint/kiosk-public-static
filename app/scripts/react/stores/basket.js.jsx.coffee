BaseStore = require './_base'

_basketItems = {}

addToBasket = (productItem)->
  if productItem.articul in _basketItems
    _basketItems[productItem.articul].count += 1
  else
    _basketItems[productItem.articul] = productItem

  console.log _basketItems
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