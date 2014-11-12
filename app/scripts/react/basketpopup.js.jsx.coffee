###* @jsx React.DOM ###

window.BasketPopup = React.createClass
  propTypes:
    cartUrl: React.PropTypes.string
    cartClearUrl: React.PropTypes.string
    items: React.PropTypes.array

  getInitialState: ->
    isVisible: false

  handleClick: (event)->
    console.log 'Я свечу событие'

  componentDidMount: ()->
    $(document).on "cart:clicked", this.handleCartClicked

  componentWillUnmount: ()->
    $(document).off "cart:clicked", this.handleCartClicked

  handleCartClicked: ()->
    @setState isVisible: true

  getDefaultProps: ->
    cartUrl: "/cart.html"
    cartClearUrl: "/cart.html?clear"
    items: [
            {
              order_product_id: 1
              product_id: 1
              price: 1200
              count: 4
              image_url: "http://cdn.sparkfun.com/r/92-92/assets/parts/1/0/2/2/7/13146-01.jpg"
              title: "title"
              description: "description"
              article: "article"
            }
          ]

  render: ->
    return `<div className='float-cart__content' onClick={this.handleClick}>
          <BasketPopupList items={this.props.items}/>
          <BasketPopupControl cartUrl={this.props.cartUrl} cartClearUrl={this.props.cartClearUrl}/>
        </div>`

window.BasketPopupList = React.createClass
  propTypes:
    items: React.PropTypes.array

  render: ->
    itemsList = @props.items.map((item) ->
      return (
        `<BasketPopupItem key={item.order_product_id} order_product_id={item.order_product_id} product_id={item.product_id} price={item.price} count={item.count} image_url={item.image_url} title={item.title} description={item.description} article={item.article}/>`
        )
    )
    
    return `<div className="float-cart__item-wrap">
        {itemsList}
      </div>`

window.BasketPopupItem = React.createClass
  propTypes:
    order_product_id: React.PropTypes.number
    product_id: React.PropTypes.number
    price: React.PropTypes.number
    count: React.PropTypes.number
    image_url: React.PropTypes.string
    title: React.PropTypes.string
    description: React.PropTypes.string
    article: React.PropTypes.string

  render: ->
    return `<div className="float-cart__item" data-order_product_id={this.props.order_product_id} data-product-id={this.props.product_id}>
          <div className="row">
            <div className="col-sm-3">
              <a className="float-cart__item__img" href={this.props.product_id}>
                <img src={this.props.image_url} alt={this.props.title}/>
              </a>
            </div>
            <div className="col-sm-5">
              <div className="float-cart__item__nfo">
                <a className="float-cart__item__name" href={this.props.product_id}>{this.props.title}</a>
                <div className="float-cart__item__param">{this.props.description}</div>
                <div className="float-cart__item__param">{this.props.article}</div>
              </div>
            </div>
            <div className="col-sm-2">
              <div className="float-cart__item__q">
                {this.props.count}
              </div>
            </div>
            <div className="col-sm-2">
              <div className="float-cart__item__price">
                {accounting.formatMoney(this.props.price * this.props.count)}
              </div>
            </div>
          </div>
        </div>`

window.BasketPopupControl = React.createClass
  propTypes:
    cartUrl: React.PropTypes.string
    cartClearUrl: React.PropTypes.string

  render: ->
    return `<div className="float-cart__control">
          <a className="cart-btn float-cart__link" href={this.props.cartUrl}>Перейти в корзину</a>
          <a className="float-cart__clear" href={this.props.cartClearUrl}>Очистить корзину</a>
        </div>`