$ ->
  isRequest = false

  $('[ks-load-more]').on 'click', (e)->
    return if isRequest

    $target = $(e.target)

    $root        = $target.parents '[ks-products-container]'
    current_page = $root.data("current-page")
    total_pages  = $root.data("total-pages")
    url          = $root.data('url') || ''

    next_page = current_page + 1

    return if next_page > total_pages

    $.ajax({
      url: url
      data:
        page: next_page
      beforeSend: (xhr)->
        isRequest = true
    })
      .done (resp)->
        $('[ks-product-item]').last().after(resp)
        $target.data("current-page", next_page)
      .always (resp)->
        isRequest = false
