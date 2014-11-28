###* @jsx React.DOM ###

STATE_LOADING = 'loading'
STATE_LOADED  = 'loaded'
STATE_ERROR   = 'error'

INSTAGRAM_API_URL = 'https://api.instagram.com/v1/'

window.InstagramFeed = React.createClass
  propTypes:
    clientId: React.PropTypes.string.isRequired
    userId: React.PropTypes.number.isRequired

  getInitialState: ->
    isVisible: false
    photos: null
    currentState: STATE_LOADING

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

  toggleVisibleState: -> @setState(isVisible: !@state.isVisible) if STATE_LOADED

  componentDidMount: ()->
    @_getPhotos()
    $(document).on "instagram:clicked", @toggleVisibleState

  componentWillUnmount: ()->
    $(document).off "instagram:clicked", @toggleVisibleState

  render: ->
    feedClasses = React.addons.classSet {
      'instagram-feed': true
      'instagram-feed_invisible': !@state.isVisible
      'instagram-feed_error': !@state.STATE_ERROR
      'instagram-feed_loading': !@state.STATE_LOADING
    }

    switch @state.currentState
      when STATE_LOADED
        `<div className={feedClasses}>
          <InstagramFeed_Carousel photos={this.state.photos}/>
        </div>`
      when STATE_LOADING
        `<div className={feedClasses}>
          Загрузка
        </div>`
      when STATE_ERROR
        `<div className={feedClasses}>
          Ошибка при загрузке фотографий
        </div>`
      else
        console.log 'Неизвестное состояние #{@state.currentState}'


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
    `<div classNameValue="instagram-feed__content">{photos}</div>`


