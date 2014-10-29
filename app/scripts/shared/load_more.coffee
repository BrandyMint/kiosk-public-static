$ ->
  isRequest = false

  LOADING_TITLE = 'Загружаю'

  $('[ks-load-more]').on 'click', (e)->
    return if isRequest

    $target = $(e.target)

    saved_title = $target.text()

    $target.text $target.data('loading-title') || LOADING_TITLE

    $root        = $target.parents '[ks-products-container]'
    current_page = $root.data("current-page") || 1
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

        $target.text saved_title

        $root.data 'current-page', next_page

        $target.hide() if next_page>=total_pages
      .always (resp)->
        isRequest = false
