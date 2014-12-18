$ ->
  # Welcome slider

  defaultCarouselOptions =
    pagination: false
    autoPlay: 5000
    navigation: true

  $('[application-slider]').each ->
    thisInner = $(this).find '.application-slider__inner'
    options = defaultCarouselOptions
    if $(this).hasClass 'b-slider_promo'
      options['singleItem'] = true
      options['autoHeight'] = true
    if $(this).hasClass 'application-slider_photos'
      options['singleItem'] = false
      options['items'] = 3
      options['itemsDesktop'] = 3
    if $(this).hasClass 'application-slider_instagram'
      options['singleItem'] = false
      options['items'] = 6
      options['itemsDesktop'] = 6
      options['lazyLoad'] = true

    $(this).owlCarousel options

