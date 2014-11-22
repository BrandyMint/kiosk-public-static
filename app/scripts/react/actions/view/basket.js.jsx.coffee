window.BasketActions =
  addItem: (productItem) ->
    BasketDispatcher.handleViewAction
      actionType: 'addToBasket'
      productItem: productItem

  addItemToServer: (productItem) ->
    $.ajax
      dataType: 'json'
      method:   'post'
      data:
        product_item_id: productItem.product_id
        count: productItem.count
      url:      Routes.vendor_cart_items(productItem.product_id, productItem.count)
      error: (xhr, status, err) ->
        console.log err
      success: (data) ->
        console.log data

  receiveBasket: () ->
    BasketDispatcher.handleViewAction
      actionType: 'receiveBasket'
      basketItems: window.cart