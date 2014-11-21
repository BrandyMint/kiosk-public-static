window.BasketActions =
  addItem: (productItem) ->
    BasketDispatcher.handleViewAction
      actionType: 'addToBasket'
      productItem: productItem