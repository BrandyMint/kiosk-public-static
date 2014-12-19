$ ->
  # mobile navigation

  menuCopy = $('#nav')
  menuCopy.mmenu({
    classes: false,
    counters: false
  })

  navOpen = $('#navopen')

  menuCopy.on 'opened.mm', ()->
    navOpen.addClass 'mmenu-open_active'
  menuCopy.on 'closed.mm', ()->
    navOpen.removeClass 'mmenu-open_active'


