window.BasketActions =
  addItem: (productItem) ->
    if @_addItemToServer productItem
      BasketDispatcher.handleViewAction
        actionType: 'addToBasket'
        productItem: productItem

  _addItemToServer: (productItem) ->
    result = false
    $.ajax
      dataType: 'json'
      method:   'post'
      data:
        product_item_id: productItem.product_id
        count: productItem.count
      url:      Routes.vendor_cart_items_path(productItem.product_id, productItem.count)
      error: (xhr, status, err) ->
        console.log err
      success: (data) ->
        console.log data
        result = true
    result

  receiveBasket: (basketItems) ->
    BasketDispatcher.handleViewAction
      actionType: 'receiveBasket'
      basketItems: basketItems