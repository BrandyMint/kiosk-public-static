$ ->
  # Touch detect
  if 'ontouchstart' of document
    $("html").addClass "feature_touch"
  else
    $("html").addClass "feature_no-touch"

  $('[tooltip]').tooltip()

  $("[range_slider]").noUiSlider(
    start: [20, 80]
    connect: true
    range: {
      'min': 0
      'max': 100
    }
  )