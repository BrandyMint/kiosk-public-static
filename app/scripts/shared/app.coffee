$ ->
  # Touch detect
  if 'ontouchstart' of document
    $("html").addClass "feature_touch"
  else
    $("html").addClass "feature_no-touch"

  # TODO Ответить: Что это и зачем?
  $('[data-slide-to]').on 'click', () ->
    slide = $(@).data('slide-to')
    target = $(@).data('target')
    $(target).carousel(slide)

  # Не нашел где это используется
  # $('@carousel').carousel()
  #$('@product-show-image').on 'click', () ->
    #$('@product-modal').modal()


