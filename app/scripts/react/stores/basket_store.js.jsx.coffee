add = ->
  return

removeItem = ->
  return

AppDispatcher = require("../dispatchers/dispatcher")
EventEmitter = require("events").EventEmitter
CartConstants = require("../constants/basket_constans")
_products = {}

AppDispatcher.register (payload) ->
  action = payload.action
  text = undefined
  switch action.actionType

    when CartConstants.CART_ADD
      add

    when CartConstants.CART_DESTROY
      removeItem
    else
      return true
  
  CartStore.emitChange()
  true

module.exports = CartStore