$ ->

  setCartItemCount = (root_item_el, count) ->

    price = root_item_el.data 'item-price'
    root_item_el.find('[cart-item-block]').each (idx, block) ->
      $block = $ block
      total = price*count
      $block.data 'total-price', total

      #price = $block.data 'price'

      $price_el = $block.find '[cart-item-price]'

      $price_el.html accounting.formatMoney total

      $selector = $block.find '[cart-item-selector]'
      $selector.val count

    updateCartTotal()

  updateCartTotal = ->
    totalPrice = 0
    $('[cart-item-block]').each (idx, block) ->
      totalPrice += $(block).data('total-price')

    $cartTotal = $ '[cart-total]'
    $cartTotal.html accounting.formatMoney totalPrice



  $('[cart-item-selector]').on 'change', ->
    $e = $ @
    root_item_el = $e.closest '[cart-item]'

    setCartItemCount root_item_el, parseInt($e.val())

