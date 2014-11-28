###* @jsx React.DOM ###

window.InstagramFeed = React.createClass
  propTypes:
    clientId: React.PropTypes.string.isRequired
    userId: React.PropTypes.number.isRequired

  getInitialState: ->
    isVisible: false

  getDefaultProps: ->
    instagramApiUrl: 'https://api.instagram.com/v1/'

  _getRequestUrl: ()->
    requestUrl = @props.instagramApiUrl + 'users/' + @props.userId + '/media/recent/?client_id=' + @props.clientId
  
  _getPhotos: ()->
    that = @
    carouselApi = $(this.refs.carousel.getDOMNode()).data('owlCarousel')
    $.ajax(
      dataType: "jsonp"
      url: that._getRequestUrl()
      success: (data) ->
        that._appendPhotos data
    )

  _appendPhotos: (instagramData)->
    carousel = $(this.refs.carousel.getDOMNode())
    content = ''
    i = 0
    
    while i < 10
      content += "<a class='instagram-feed__photo' lightbox rel='instagram-stack' href='" + instagramData.data[i].images.standard_resolution.url + "'><img class='lazyOwl' data-src='" + instagramData.data[i].images.low_resolution.url + "'></img></a>"
      i++

    carousel.html content
    @_initCarousel()

  _initCarousel: ()->
    $(this.refs.carousel.getDOMNode()).owlCarousel
      items: 6
      itemsDesktop: 6
      pagination: false
      autoPlay: 5000
      navigation: true
      lazyLoad: true

  handleInstagramClicked: ()->
    if @state.isVisible
      @setState isVisible: false
    else
      @setState isVisible: true

  componentDidMount: ()->
    @_getPhotos()
    $(document).on "instagram:clicked", @handleInstagramClicked

  render: ->
    classNameValue = "instagram-feed"
    classNameValue += " instagram-feed_invisible" if @state.isVisible is false
    `<div className={classNameValue}>
      <div className="instagram-feed__content" ref="carousel"></div>
    </div>`