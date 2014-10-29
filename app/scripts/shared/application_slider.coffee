$ ->
  # Welcome slider

  defaultCarouselOptions =
    singleItem: true
    pagination: false
    responsiveBaseWidth: $('[application-slider]')
    autoPlay: 5000,
    navigation: true

  $('[application-slider]').each ->
    thisInner = $(this).find '.application-slider__inner'
    options = defaultCarouselOptions
    if $(this).hasClass 'application-slider_photos'
      options['singleItem'] = false
      options['items'] = 3
      options['itemsDesktop'] = 3

    thisInner.owlCarousel options

