$ ->
  # mobile navigation

  # TODO Что делает этот код?
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


