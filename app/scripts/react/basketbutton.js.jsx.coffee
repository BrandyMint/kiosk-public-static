###* @jsx React.DOM ###

window.BasketButton = React.createClass
  propTypes:
    itemsCount: React.PropTypes.object.isRequired
    price: React.PropTypes.object

  render: ->
    if @props.itemsCount > 0
      return `<a className='navbar-cart-btn navbar-cart-btn-full' data-cart={this.props.itemsCount} href='cart.html'>
          <span className='navbar-cart-btn-icon'></span>
          <span className='navbar-cart-btn-caption'>
            Корзина {this.props.price}
          </span>
        </a>`
    else
      return `<a className='navbar-cart-btn navbar-cart-btn-empty' href='cart.html'>
          <span className='navbar-cart-btn-icon'></span>
          <span className='navbar-cart-btn-caption'>
            Корзина
          </span>
        </a>`