$ ->
  # Touch detect
  if 'ontouchstart' of document
    $("html").addClass "feature_touch"
  else
    $("html").addClass "feature_no-touch"

  $('[tooltip]').tooltip()

  if $("[range_slider]").length
    $("[range_slider]").noUiSlider(
      start: [20, 80]
      connect: true
      range: {
        'min': 0
        'max': 100
      }
    )