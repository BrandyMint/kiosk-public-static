###* @jsx React.DOM ###

STATE_LOADING = 'loading'
STATE_LOADED  = 'loaded'
STATE_ERROR   = 'error'

INSTAGRAM_API_URL = 'https://api.instagram.com/v1/'

InstagramFeed_Mixin =
  _getRequestUrl: ->
    INSTAGRAM_API_URL + 'users/' + @props.userId + '/media/recent/?client_id=' + @props.clientId
  
  _loadPhotos: ->
    $.ajax(
      dataType: "jsonp"
      url: @_getRequestUrl()
      success: (photos) =>
        if @isMounted() && photos?
          @setState {
            currentState: STATE_LOADED
            photos: photos.data
          }
      error: (data) =>
        @_activateErrorState()
    )

  _activateErrorState: -> @setState(currentState: STATE_ERROR) if @isMounted()

window.InstagramFeed_Controllable = React.createClass
  propTypes:
    isVisible: React.PropTypes.bool.isRequired
    clientId:  React.PropTypes.string.isRequired
    userId:    React.PropTypes.number.isRequired

  getInitialState: ->
    isVisible: @props.isVisible

  componentDidMount: ->
    $(document).on "instagram:clicked", @toggleVisibleState

  componentWillUnmount: ->
    $(document).off "instagram:clicked", @toggleVisibleState

  render: ->
    if @state.isVisible
      return `<InstagramFeed clientId={this.props.clientId} userId={this.props.userId} />`
    else
      return `<span/>`

  toggleVisibleState: -> @setState(isVisible: !@state.isVisible) if STATE_LOADED

window.InstagramFeed = React.createClass
  mixins: [InstagramFeed_Mixin]

  propTypes:
    clientId: React.PropTypes.string.isRequired
    userId: React.PropTypes.number.isRequired

  getInitialState: ->
    currentState: STATE_LOADING
    isVisible: false
    photos: null
    
  componentDidMount: ->
    @_loadPhotos()

  render: ->
    switch @state.currentState
      when STATE_LOADED  then `<InstagramFeed_Carousel photos={ this.state.photos } />`
      when STATE_LOADING then `<InstagramFeed_Spinner/>`
      when STATE_ERROR   then `<InstagramFeed_Error/>`
      else console.warn 'Неизвестное состояние #{@state.currentState}'

window.InstagramFeed_Error = React.createClass
  render: ->
    `<div className='instagram-feed instagram-feed_error'>
      Ошибка при загрузке фотографий
    </div>`

window.InstagramFeed_Spinner = React.createClass
  render: ->
    `<div className='instagram-feed instagram-feed_loading'>
      <span className='instagram-feed__loader'/>
    </div>`

window.InstagramFeed_Photo = React.createClass
  propTypes:
    photo: React.PropTypes.object.isRequired

  render: ->
    `<a className='instagram-feed__photo' href={this.props.photo.standard_resolution.url}>
      <img className='lazyOwl' data-src={this.props.photo.low_resolution.url}/>
    </a>`


window.InstagramFeed_Carousel = React.createClass
  propTypes:
    photos: React.PropTypes.array.isRequired

  componentDidMount: ->
    @_initCarousel()

  componentWillUnmount: ->
    @_destroyCarousel()

  render: ->
    photos = _.map @props.photos, (photo) ->
      `<InstagramFeed_Photo
        photo={photo.images}
        key={photo.id} />`
    
    return `<div className="instagram-feed">{photos}</div>`

  _initCarousel: ->
    $(@getDOMNode()).owlCarousel
      items: 6
      itemsDesktop: 6
      pagination: false
      autoPlay: 5000
      navigation: true
      lazyLoad: true

  _destroyCarousel: ->
    $(@getDOMNode()).data('owlCarousel').destroy()


