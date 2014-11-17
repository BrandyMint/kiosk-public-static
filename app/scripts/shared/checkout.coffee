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

  setOnlyCity = (city) ->
    $c = $ '[city-field]'
    saved_city = $c.data 'saved-city'
    if city
      unless $c.attr 'disabled'
        $c.attr 'disabled', 'disabled'
        $c.data 'saved-city', $c.val() # unless saved_city

      $c.val city
    else

      if $c.attr 'disabled'
        $c.removeAttr 'disabled'
        $c.val saved_city

  $('[delivery-type]').on 'change', ->
    $e = $ @

    setOnlyCity $e.data('delivery-only-city')

    setCheckoutDeliveryPrice parseInt $e.data('delivery-price')

    toggleDeliveryOnlyElementsVisibility $e.data('delivery-type')=='selfdelivery'
