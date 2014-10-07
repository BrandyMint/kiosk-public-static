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

  menuCopy = $('#nav').clone()
  menuCopy.appendTo($('body')).removeClass('categories-nav').find('*').removeAttr('class')
  menuCopy.mmenu()
