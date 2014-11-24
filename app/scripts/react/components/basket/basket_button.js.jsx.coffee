###* @jsx React.DOM ###

window.BasketButton = React.createClass
  propTypes:
    itemsCount: React.PropTypes.object.isRequired
    totalPrice: React.PropTypes.object
    cartUrl: React.PropTypes.object

  render: ->
    if @props.itemsCount > 0
      return `<BasketButton_Full cartUrl={this.props.cartUrl} itemsCount={this.props.itemsCount} totalPrice={this.props.totalPrice}/>`
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
  getInitialState: ->
    isMessageVisible: false
  
  handleClick: ->
    @setState isMessageVisible: true unless @state.isMessageVisible

  handleMouseLeave: ->
    @setState isMessageVisible: false
  
  render: ->
    classNameValue = 'navbar-cart-btn-msg'
    classNameValue += " navbar-cart-btn-msg_visible" if @state.isMessageVisible
    
    return `<span className='navbar-cart-btn navbar-cart-btn-empty' onMouseLeave={this.handleMouseLeave} onClick={this.handleClick}>
          <span className='navbar-cart-btn-icon'></span>
          <span className='navbar-cart-btn-caption'>
            Корзина
          </span>
          <span className={classNameValue}>Корзина пуста</span>
        </span>`