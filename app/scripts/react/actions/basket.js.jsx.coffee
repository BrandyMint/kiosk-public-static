window.basketActions =

  addToCart: (data) ->
    window.BasketDispatcher.handleViewAction
      actionType: 'addToCart'
      data: data