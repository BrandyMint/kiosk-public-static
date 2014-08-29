$ ->
  @orderModal = $('@order-modal')
  $('@orders-list__table-modal-btn').on 'click', () =>
    @orderModal.modal('show')

  categoriesSelect = $('@products__new-form-select-category')
  categoriesSelectNew = $('@products__new-form-select-category-new')
  categoriesAddBtn = $('@products__new-form-add-category-btn')
  categoriesSelectDefault = $('@products__new-form-select-category-default')
  newCategoryForm = $('@products__new-form-new-category')
  newCategoryInput = newCategoryForm.find('input')
  newCategoryClose = $('@products__new-form-new-category-close')

  newCategoryForm.hide()
  categoriesSelect.on 'change', () ->
    if categoriesSelectNew.prop('selected')
      showCategoryInput()
    if categoriesSelectDefault.prop('selected')
      categoriesAddBtn.hide()
    else
      categoriesAddBtn.hide()

  categoriesAddBtn.on 'click', (e) ->
    e.preventDefault()
    showCategoryInput()

  showCategoryInput = ->
    categoriesSelect.hide()
    newCategoryForm.show()
    newCategoryInput.focus()

  hideCategoryInput = ->
    categoriesSelect.show()
    newCategoryForm.hide()

  newCategoryClose.on 'click', (e) ->
    e.preventDefault()
    newCategoryForm.hide()
    categoriesSelect.show()
    categoriesSelectDefault.prop('selected','selected')
    categoriesAddBtn.show()

  productVariantsAdd = $('@products__new-form-variants-add')
  productVariantsTitle = $('@products__new-form-variants-title')
  productVariantsItem = $('@products__new-form-variants-item')
  productVariantsPlace = $('@products__new-form-variants-place')

  productVariantsTitle.hide()
  productVariantsPlace.hide()

  productVariantsAdd.on 'click', (e) ->
    e.preventDefault()
    productVariantsTitle.show()
    productVariantsPlace.show()
    html = productVariantsItem.html()
    productVariantsPlace.append(html)


  $('@jump').on 'click', (e) ->
    href = $(this).data('href')
    if href != ''
      if event.shiftKey || event.ctrlKey || event.metaKey
        window.open(target, '_blank')
      else
        window.location = href

  $('@jump .dropdown, @jump input').on 'click', (e) ->
    e.stopPropagation()
