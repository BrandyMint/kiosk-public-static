###* @jsx React.DOM ###

window.AddToBasketButton = React.createClass
  propTypes:
    product_item_id:    React.PropTypes.number.isRequired
    product_id:         React.PropTypes.number.isRequired
    price:              React.PropTypes.number
    count:              React.PropTypes.number
    image_url:          React.PropTypes.string
    title:              React.PropTypes.string
    description:        React.PropTypes.string
    articul:            React.PropTypes.number

  getDefaultProps: ->
    product_item_id: 4
    product_id: 2
    price: 123
    count: 1
    image_url: 'http://placehold.it/120x120'
    title: 'title'
    description: 'descr'
    articul: 123

  addToBasket: ->
    props = $('[product-select] option:selected').data 'productitem'
    if props?
        BasketActions.addItem props
  
  render: ->
    return `<button className="products__show-item-cart-btn" onClick={this.addToBasket}>В корзину</button>`