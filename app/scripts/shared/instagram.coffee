$ ->
  # Instagram slider

  instagramContainer = $('[ks-instagram]')
  instagramTrigger = $('[ks-instagram-trigger]')

  instagramTrigger.on 'click', (e)->
    e.preventDefault()
    instagramTrigger.toggleClass 'active'
    instagramContainer.parent().toggle()

  $.ajax(
    dataType: "jsonp"
    url: 'https://api.instagram.com/v1/users/3123/media/recent/?client_id=295b9ad8c3304e5f8cf9a27da8014082'
    success: (data) ->
      i = 0
      while i < 10
        instagramContainer.data('owlCarousel').addItem "<a class='instagram-photo' lightbox rel='instagram-stack' href='" + data.data[i].images.standard_resolution.url + "'><img class='lazyOwl' data-src='" + data.data[i].images.low_resolution.url + "'></img></a>"
        i++
  )