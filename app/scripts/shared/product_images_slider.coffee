$ ->
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


