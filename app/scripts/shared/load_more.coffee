isRequest = false

$('[load-more]').on 'click', (e)->
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


