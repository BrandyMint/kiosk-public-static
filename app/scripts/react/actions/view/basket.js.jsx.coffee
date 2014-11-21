window.BasketActions =
  _addItem: (productItem) ->
    BasketDispatcher.handleViewAction
      actionType: 'addToBasket'
      productItem: productItem