###* @jsx React.DOM ###

window.BasketButton = React.createClass
  propTypes:
    itemsCount: React.PropTypes.object.isRequired
    totalPrice: React.PropTypes.object
    cartUrl: React.PropTypes.object

  getDefaultProps: ->
    cartUrl: "/cart.html"

  getInitialState: ->
    itemsCount: BasketStore.getBasketCount()
    totalPrice: 0

  componentDidMount: ()->
    BasketStore.addChangeListener @_onChange

  _onChange: ()->
    @setState itemsCount: BasketStore.getBasketCount()

  render: ->
    if @state.itemsCount > 0
      return `<BasketButton_Full cartUrl={this.props.cartUrl} itemsCount={this.state.itemsCount} totalPrice={this.props.totalPrice}/>`
    else
      return `<BasketButton_Empty/>`

window.BasketButton_Full = React.createClass
  propTypes:
    itemsCount: React.PropTypes.object.isRequired
    totalPrice: React.PropTypes.object
    cartUrl: React.PropTypes.object
  render: ->
    return `<a className='navbar-cart-btn navbar-cart-btn-full' data-cart={this.props.itemsCount} href={this.props.cartUrl}>
          <span className='navbar-cart-btn-icon'></span>
          <span className='navbar-cart-btn-caption'>
            Корзина — {accounting.formatMoney(this.props.totalPrice)}
          </span>
        </a>`

window.BasketButton_Empty = React.createClass
  render: ->
    return `<span className='navbar-cart-btn navbar-cart-btn-empty'>
          <span className='navbar-cart-btn-icon'></span>
          <span className='navbar-cart-btn-caption'>
            Корзина
          </span>
        </span>`