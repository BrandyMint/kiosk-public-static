window.basketActions =

  addToBasket: (data) ->
    window.BasketDispatcher.handleViewAction
      actionType: 'addToBasket'
      data: data