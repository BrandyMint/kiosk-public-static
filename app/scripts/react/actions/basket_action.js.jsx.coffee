AppDispatcher = require("../dispatchers/dispatcher")
CartConstants = require("../constants/basket_constans")
basketActions =

  create: (id) ->
    AppDispatcher.handleViewAction
      actionType: TodoConstants.CART_CREATE
      id: id

    return

  destroy: (id) ->
    AppDispatcher.handleViewAction
      actionType: TodoConstants.CART_DESTROY
      id: id

    return

module.exports = basketActions