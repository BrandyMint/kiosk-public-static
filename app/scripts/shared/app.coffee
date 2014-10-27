$ ->
  # Touch detect
  if 'ontouchstart' of document
    $("html").addClass "feature_touch"
  else
    $("html").addClass "feature_no-touch"

  $('@carousel').carousel()
  $('[data-slide-to]').on 'click', () ->
    slide = $(@).data('slide-to')
    target = $(@).data('target')
    $(target).carousel(slide)

  $('@product-show-image').on 'click', () ->
    $('@product-modal').modal()


  $('@jump').on 'click', (e) ->
    href = $(this).data('href')
    if href != ''
      if event.shiftKey || event.ctrlKey || event.metaKey
        window.open(target, '_blank')
      else
        window.location = href

  $('@jump .dropdown, @jump input').on 'click', (e) ->
    e.stopPropagation()


  isRequest = false
  $('@more-products').on 'click', (e)->
    return if isRequest

    target = $(e.target)
    current_page = target.data("current-page")
    total_pages = target.data("total-pages")

    next_page = current_page + 1

    return if next_page > total_pages

    $.ajax({
      url: '',
      data:
        page: next_page
      beforeSend: (xhr)->
        isRequest = true
    })
      .done (resp)->
        $('@product-item').last().after(resp)
        target.data("current-page", next_page)
      .always (resp)->
        isRequest = false

  # Lightbox

  $('.js-lightbox').fancybox({
    padding: 0
    margin: 0
    helpers: {
      thumbs: {
        width: 8
        height: 8
      }
    }
    tpl: {
      closeBtn: '<a title="Close" class="fancybox-item fancybox-close" href="javascript:;"><i></i></a>'
      next: '<a title="Next" class="fancybox-nav fancybox-next" href="javascript:;"><i></i></a>'
      prev: '<a title="Previous" class="fancybox-nav fancybox-prev" href="javascript:;"><i></i></a>'
    }
  })

  # Style changer

  logo = $('.navbar-brand-image')

  $('.b-theme-switch__item').on 'click', ()->
    classlistVal = $(this).data "classlist"
    logoUrl = $(this).data "logourl"
    $('body').attr 'class', classlistVal
    logo.attr 'src', logoUrl


  # Welcome slider

  defaultCarouselOptions =
    singleItem: true
    pagination: false
    responsiveBaseWidth: $('.application-slider')
    autoPlay: 5000,
    navigation: true

  

  $('.application-slider').each ->
    thisInner = $(this).find '.application-slider__inner'
    options = defaultCarouselOptions
    if $(this).hasClass 'application-slider_photos'
      options['singleItem'] = false
      options['items'] = 3
      options['itemsDesktop'] = 3

    thisInner.owlCarousel options


  # Product carousel (http://owlgraphic.com/owlcarousel)

  productSlider = $('#product-slider')
  productThumbs = $('#product-thumbs')

  syncPosition = (el) ->
    current = @currentItem
    productThumbs.find(".owl-item").removeClass("synced").eq(current).addClass "synced"
    center current  if productThumbs.data("owlCarousel") isnt `undefined`
    return

  center = (number) ->
    sync2visible = productThumbs.data("owlCarousel").owl.visibleItems
    num = number
    found = false
    for i of sync2visible
      found = true  if num is sync2visible[i]
    if found is false
      if num > sync2visible[sync2visible.length - 1]
        productThumbs.trigger "owl.goTo", num - sync2visible.length + 2
      else
        num = 0  if num - 1 is -1
        productThumbs.trigger "owl.goTo", num
    else if num is sync2visible[sync2visible.length - 1]
      productThumbs.trigger "owl.goTo", sync2visible[1]
    else productThumbs.trigger "owl.goTo", num - 1  if num is sync2visible[0]

  productSlider.owlCarousel({
    singleItem: true
    afterAction: syncPosition
  })

  productThumbs.owlCarousel({
    items: 4
    pagination: false
    afterInit: (el) ->
      el.find(".owl-item").eq(0).addClass "synced"
      return
  })

  productThumbs.on "click", ".owl-item", (e) ->
    e.preventDefault()
    number = $(this).data("owlItem")
    productSlider.trigger "owl.goTo", number
    return

  # mobile navigation

  menuCopy = $('#nav')
  menuCopy.mmenu({
    classes: "mm-slide",
    counters: false
  })

  navOpen = $('#navopen')

  menuCopy.on 'opened.mm', ()->
    navOpen.addClass 'mmenu-open_active'
  menuCopy.on 'closed.mm', ()->
    navOpen.removeClass 'mmenu-open_active'

  #floating cart
  
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
      
