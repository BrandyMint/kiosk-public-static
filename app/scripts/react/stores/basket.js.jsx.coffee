BaseStore = require './_base'

_basketItems = []

addToBasket = (productItem)->
  basketItem = window.basketStore.findItem productItem
  if basketItem?
    basketItem.count += 1
  else
    _basketItems.push productItem
  return


window.BasketDispatcher.register (payload) ->
  action = payload.action
  
  switch action.actionType
    when 'addToBasket'
      addToBasket action.productItem
      window.basketStore.emitChange()
      break

window.basketStore = _.extend new BaseStore(), {
  findItem: (productItem) ->
    thisItem = _.findIndex _basketItems, (item) ->
      item.product_item_id == productItem.product_item_id
    console.log _basketItems[thisItem]
    return _basketItems[thisItem]
  
  getBasketItems: ->
    _basketItems

  getBasketCount: ->
    total = 0
    _.forEach _basketItems, (item)->
      total += item.count
    return total
}