#floating cart
$ ->

  floatCart = $('.float-cart')

  if floatCart.length
    floatCartLockedClass = 'float-cart_locked'
    floatCartPosition = floatCart.offset().top
    navbarCollapse = $('.navbar-collapse')

    getRightOffset = (el) ->
      rt = $(window).width() - el.width()
      return rt/2 - 14

    recalcFloatCartPosition = () ->
      floatCart.css {right: getRightOffset navbarCollapse}

    $(window).on "scroll", (e) ->
      if $(@).scrollTop() >= floatCartPosition
        floatCart.addClass floatCartLockedClass
        recalcFloatCartPosition()
      else
        floatCart.removeClass floatCartLockedClass
        floatCart.css {right: 0 }

    $(window).on "resize", (e) ->
      if floatCart.hasClass floatCartLockedClass
        recalcFloatCartPosition()
      

