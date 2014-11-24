window.BasketActions =
  addItem: (productItem) ->
    @_addItemToServer productItem

  _addItemToServer: (productItem) ->
    productId = productItem.product_id
    count = productItem.count
    
    $.ajax
      dataType: 'json'
      method:   'post'
      data:
        product_item_id: productId
        count: count
      url:      Routes.vendor_cart_items_path(productId, count)
      error: (xhr, status, err) ->
        console.log err
      success: (data) ->
        BasketDispatcher.handleServerAction
          actionType: 'addToBasket'
          productItem: productItem


  receiveBasket: (basketItems) ->
    BasketDispatcher.handleViewAction
      actionType: 'receiveBasket'
      basketItems: basketItems