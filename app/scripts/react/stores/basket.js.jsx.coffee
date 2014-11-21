BaseStore = require './_base'

_basketItems = []

window.BasketDispatcher.register (payload) ->
  action = payload.action
  
  switch action.actionType
    when 'productAddedToBasket'
      BasketStore._addItem action.productItem
      BasketStore.emitChange()
      break

    when 'receiveBasket'
      BasketStore._receiveBasket action.basketItems
      BasketStore.emitChange()
      break

window.BasketStore = _.extend new BaseStore(), {
  getBasketItems: ->
    _basketItems

  getBasketCount: ->
    total = 0
    _.forEach _basketItems, (item)->
      total += item.count
    return total

  _findItem: (productItem) ->
    thisItem = _.findIndex _basketItems, (item) ->
      item.product_item_id == productItem.product_item_id
    return _basketItems[thisItem]

  _addItem: (productItem)->
    basketItem = BasketStore._findItem productItem
    if basketItem?
      basketItem.count += 1
    else
      productItem.count = 1
      _basketItems.push productItem

  _receiveBasket: (basketItems)->
    if basketItems?
      _.forEach basketItems.items, (basketItem)->
        _basketItems.push basketItem.product_item


}