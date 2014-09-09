$ ->
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
