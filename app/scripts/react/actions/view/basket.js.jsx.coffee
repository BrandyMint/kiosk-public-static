window.basketActions =

  addToBasket: (productItem) ->
    BasketDispatcher.handleViewAction
      actionType: 'addToBasket'
      productItem: productItem