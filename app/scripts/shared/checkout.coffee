$ ->
  $checkoutTotal = $ '[checkout-total]'

  setCheckoutDeliveryPrice= (price)->
    $checkoutTotal.data 'delivery-price', price
    updateCheckoutTotal()

  updateCheckoutTotal= ->
    totalPrice = $checkoutTotal.data('delivery-price') + $checkoutTotal.data('products-price')

    $checkoutTotal.html accounting.formatMoney totalPrice

  toggleDeliveryOnlyElementsVisibility= (visible) ->

    $el = $('[delivery-only-field]')

    if visible
      $el.slideUp()
    else
      $el.slideDown()


  $('[delivery-type]').on 'change', ->
    $e = $ @

    setCheckoutDeliveryPrice parseInt $e.data('delivery-price')

    toggleDeliveryOnlyElementsVisibility $e.data('delivery-type')=='selfdelivery'
