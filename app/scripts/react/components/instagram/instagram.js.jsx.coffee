###* @jsx React.DOM ###

STATE_LOADING = 'loading'
STATE_LOADED  = 'loaded'
STATE_ERROR   = 'error'

INSTAGRAM_API_URL = 'https://api.instagram.com/v1/'

InstagramFeed_Mixin =
  _getRequestUrl: ()->
    requestUrl = INSTAGRAM_API_URL + 'users/' + @props.userId + '/media/recent/?client_id=' + @props.clientId
  
  _getPhotos: ()->
    $.ajax(
      dataType: "jsonp"
      url: @_getRequestUrl()
      success: (data) =>
        @setState currentState: STATE_LOADED, photos: data if @isMounted()
      error: (data) =>
        @setState currentState: STATE_ERROR if @isMounted()
    )

window.InstagramFeed_Controllable = React.createClass
  propTypes:
    isVisible: React.PropTypes.bool.isRequired
    clientId:  React.PropTypes.string.isRequired
    userId:    React.PropTypes.number.isRequired

  getInitialState: ->
    isVisible: @props.isVisible

  toggleVisibleState: -> @setState(isVisible: !@state.isVisible) if STATE_LOADED

  componentDidMount: ()->
    $(document).on "instagram:clicked", @toggleVisibleState

  componentWillUnmount: ()->
    $(document).off "instagram:clicked", @toggleVisibleState

  render: ->
    if @state.isVisible
      return `<InstagramFeed clientId={this.props.clientId} userId={this.props.userId} />`
    else
      return `<span></span>`

window.InstagramFeed = React.createClass
  propTypes:
    clientId: React.PropTypes.string.isRequired
    userId: React.PropTypes.number.isRequired

  mixins: [InstagramFeed_Mixin]

  getInitialState: ->
    isVisible: false
    photos: null
    currentState: STATE_LOADING

  componentDidMount: ()->
    @_getPhotos()

  render: ->
    switch @state.currentState
      when STATE_LOADED
        `<InstagramFeed_Carousel photos={this.state.photos}/>`
      when STATE_LOADING
        `<InstagramFeed_Spinner/>`
      when STATE_ERROR
        `<InstagramFeed_Error/>`
      else
        console.log 'Неизвестное состояние #{@state.currentState}'

window.InstagramFeed_Error = React.createClass
  render: ->
    `<div className='instagram-feed instagram-feed_error'>
      Ошибка при загрузке фотографий
    </div>`

window.InstagramFeed_Spinner = React.createClass
  render: ->
    `<div className='instagram-feed instagram-feed_loading'>
      <span className='instagram-feed__loader'></span>
    </div>`

window.InstagramFeed_Photo = React.createClass
  propTypes:
    photo: React.PropTypes.object.isRequired

  render: ->
    `<a className='instagram-feed__photo' href={this.props.photo.images.standard_resolution.url}><img className='lazyOwl' data-src={ this.props.photo.images.low_resolution.url }></img></a>`


window.InstagramFeed_Carousel = React.createClass
  propTypes:
    photos: React.PropTypes.object.isRequired

  _initCarousel: ()->
    $(@getDOMNode()).owlCarousel
      items: 6
      itemsDesktop: 6
      pagination: false
      autoPlay: 5000
      navigation: true
      lazyLoad: true

  componentDidMount: ()->
    @_initCarousel()

  render: ->
    photos = _.map @props.photos.data, (photo) -> `<InstagramFeed_Photo photo={photo} key={photo.id} />`
    `<div className="instagram-feed">{photos}</div>`


