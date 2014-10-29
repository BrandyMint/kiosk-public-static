$ ->
  $('[ks-jump]').on 'click', (e) ->
    href = $(this).attr 'ks-jump'
    if href != ''
      if event.shiftKey || event.ctrlKey || event.metaKey
        window.open(target, '_blank')
      else
        window.location = href

  $('[ks-jump] .dropdown, [ks-jump] input').on 'click', (e) ->
    e.stopPropagation()
