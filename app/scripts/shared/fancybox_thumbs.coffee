#!
# * Thumbnail helper for fancyBox
# * version: 1.0.7 (Mon, 01 Oct 2012)
# * @requires fancyBox v2.0 or later
# *
# * Usage:
# *     $(".fancybox").fancybox({
# *         helpers : {
# *             thumbs: {
# *                 width  : 50,
# *                 height : 50
# *             }
# *         }
# *     });
# *
# 
(($) ->
  
  #Shortcut for fancyBox object
  F = $.fancybox
  
  #Add helper object
  F.helpers.thumbs =
    defaults:
      width: 50 # thumbnail width
      height: 50 # thumbnail height
      position: "bottom" # 'top' or 'bottom'
      source: (item) -> # function to obtain the URL of the thumbnail image
        href = undefined
        href = $(item.element).find("img").attr("src")  if item.element
        href = item.href  if not href and item.type is "image" and item.href
        href

    wrap: null
    list: null
    width: 0
    init: (opts, obj) ->
      that = this
      list = undefined
      thumbWidth = opts.width
      thumbHeight = opts.height
      thumbSource = opts.source
      
      #Build list structure
      list = ""
      n = 0

      while n < obj.group.length
        list += "<li><a style=\"width:" + thumbWidth + "px;height:" + thumbHeight + "px;\" href=\"javascript:jQuery.fancybox.jumpto(" + n + ");\"></a></li>"
        n++
      @wrap = $("<div id=\"fancybox-thumbs\"></div>").addClass(opts.position).appendTo("body")
      @list = $("<ul>" + list + "</ul>").appendTo(@wrap)
      
      #Load each thumbnail
      $.each obj.group, (i) ->
        href = thumbSource(obj.group[i])
        return  unless href
        
        #Calculate thumbnail width/height and center it
        $("<img />").load(->
          width = @width
          height = @height
          widthRatio = undefined
          heightRatio = undefined
          parent = undefined
          return  if not that.list or not width or not height
          widthRatio = width / thumbWidth
          heightRatio = height / thumbHeight
          parent = that.list.children().eq(i).find("a")
          if widthRatio >= 1 and heightRatio >= 1
            if widthRatio > heightRatio
              width = Math.floor(width / heightRatio)
              height = thumbHeight
            else
              width = thumbWidth
              height = Math.floor(height / widthRatio)
          $(this).css
            width: width
            height: height
            top: Math.floor(thumbHeight / 2 - height / 2)
            left: Math.floor(thumbWidth / 2 - width / 2)

          parent.width(thumbWidth).height thumbHeight
          $(this).hide().appendTo(parent).fadeIn 300
          return
        ).attr "src", href
        return

      
      #Set initial width
      @width = @list.children().eq(0).outerWidth(true)
      @list.width(@width * (obj.group.length + 1)).css "left", Math.floor($(window).width() * 0.5 - (obj.index * @width + @width * 0.5))
      return

    beforeLoad: (opts, obj) ->
      
      #Remove self if gallery do not have at least two items
      if obj.group.length < 2
        obj.helpers.thumbs = false
        return


    afterShow: (opts, obj) ->
      
      #Check if exists and create or update list
      if @list
        @onUpdate opts, obj
      else
        @init opts, obj
      
      #Set active element
      @list.children().removeClass("active").eq(obj.index).addClass "active"
      return

    
    #Center list
    onUpdate: (opts, obj) ->
      if @list
        @list.stop(true).animate
          left: Math.floor($(window).width() * 0.5 - (obj.index * @width + @width * 0.5))
        , 150
      return

    beforeClose: ->
      @wrap.remove()  if @wrap
      @wrap = null
      @list = null
      @width = 0
      return

  return
) jQuery