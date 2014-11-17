$ ->
  $cartTotal = $ '[cart-total]'

  setCartItemCount = (root_item_el, count) ->
    price = + root_item_el.data 'item-price'
    total = price*count

    root_item_el.data 'item-total-price', total

    root_item_el.find('[cart-item-block]').each (idx, block) ->
      $block = $ block

      $price_el = $block.find '[cart-item-total-price]'
      $price_el.html accounting.formatMoney total

      $selector = $block.find '[cart-item-selector]'
      $selector.val count

    updateCartTotal()

  updateCartTotal = ->
    totalPrice = 0
    $('[cart-item]').each (idx, block) ->
      totalPrice += + $(block).data('item-total-price')

    $cartTotal.html accounting.formatMoney totalPrice


  $('[cart-item-selector]').on 'change', ->
    $e = $ @
    root_item_el = $e.closest '[cart-item]'

    setCartItemCount root_item_el, parseInt($e.val())

