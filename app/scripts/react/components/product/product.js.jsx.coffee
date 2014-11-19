###* @jsx React.DOM ###

window.Product = React.createClass
  propTypes:
    order_product_id: React.PropTypes.number
    product_id: React.PropTypes.number
    price: React.PropTypes.number
    count: React.PropTypes.number
    image_url: React.PropTypes.string
    title: React.PropTypes.string
    description: React.PropTypes.string

  getDefaultProps: ->
    order_product_id: 4
    product_id: 2
    price: 123
    count: 1
    image_url: 'http://placehold.it/120x120'
    title: 'title'
    description: 'descr'

  addToCart: ->
    window.basketActions.addToCart @props
  
  render: ->
    return `<button onClick={this.addToCart}> addtocart </button>`