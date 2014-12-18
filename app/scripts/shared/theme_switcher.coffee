$ ->
  # Style changer

  logo = $('.b-logo__img')

  $('[ks-theme-switcher]').on 'click', ()->
    classlistVal = $(this).data "classlist"
    logoUrl = $(this).data "logourl"
    $('body').attr 'class', classlistVal
    logo.attr 'src', logoUrl
