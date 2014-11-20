window.basketActions =

  addToBasket: (productItem) ->
    window.BasketDispatcher.handleViewAction
      actionType: 'addToBasket'
      productItem: productItem