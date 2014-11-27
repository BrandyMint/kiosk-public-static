$ ->
  # Instagram slider

  instagramContainer = $('[ks-instagram]')
  instagramTrigger = $('[ks-instagram-trigger]')

  instagramRequestUrl = 'https://api.instagram.com/v1/users/' + instagramContainer.data('user') + '/media/recent/?client_id=' + instagramContainer.data('client')

  instagramTrigger.on 'click', (e)->
    e.preventDefault()
    instagramTrigger.toggleClass 'active'
    instagramContainer.parent().toggle()

  $.ajax(
    dataType: "jsonp"
    url: instagramRequestUrl
    success: (data) ->
      i = 0
      while i < 10
        instagramContainer.data('owlCarousel').addItem "<a class='instagram-photo' lightbox rel='instagram-stack' href='" + data.data[i].images.standard_resolution.url + "'><img class='lazyOwl' data-src='" + data.data[i].images.low_resolution.url + "'></img></a>"
        i++
  )