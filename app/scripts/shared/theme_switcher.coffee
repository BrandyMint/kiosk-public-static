$ ->
  # Style changer

  logo = $('.navbar-brand-image')

  $('[ks-theme-switcher]').on 'click', ()->
    classlistVal = $(this).data "classlist"
    logoUrl = $(this).data "logourl"
    $('body').attr 'class', classlistVal
    logo.attr 'src', logoUrl
