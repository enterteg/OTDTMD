panView = (width, height) ->

  @each ->
    panViewWidthType = 'static'
    panViewHeightType = 'static'
    panId = @id + 'Pan'
    panMaskId = @id + 'PanMask'
    mouseState = 'up'
    mouseStartX = 0
    mouseStartY = 0
    mouseDropX = 0
    mouseDropY = 0
    cssWidth = undefined
    cssHeight = undefined
    eThis = this
    # show image

    MouseEvent = (e) ->
      @e = if e then e else window.event
      @source = if e.target then e.target else e.srcElement
      @x = if @e.pageX then @e.pageX else @e.clientX
      @y = if @e.pageY then @e.pageY else @e.clientY
      if window.event
        @x = if document.body.scrollLeft then @x + document.body.scrollLeft else @x
        @y = if document.body.scrollTop then @y + document.body.scrollTop else @y
      return

    GetElementBounds = (o) ->
      @width = o.clientWidth
      @height = o.clientHeight
      @minX = width - (@width)
      @minY = height - (@height)
      @maxX = 0
      @maxY = 0
      return

    $(this).css 'display', 'block'
    # check arguments
    if width == 'auto'
      width = if @clientWidth < document.body.clientWidth then @clientWidth else document.body.clientWidth
      panViewWidthType = 'dynamic'
    if height == 'auto'
      height = if @clientHeight < document.body.clientHeight then @clientHeight else document.body.clientHeight
      panViewHeightType = 'dynamic'
    bounds = new GetElementBounds(eThis)
    $(this).wrap '<div id="' + panId + '" style="width:' + width + 'px; height:' + height + 'px; overflow:hidden; position: relative;"><div id="' + panMaskId + '" style="left:0px;top:0px;position:relative;"></div></div>'
    $(document).resize (e) ->
      if panViewWidthType == 'dynamic'
        width = if @clientWidth < document.body.clientWidth then @clientWidth else document.body.clientWidth
        $('div#' + panId).css 'width', width + 'px'
      if panViewHeightType == 'dynamic'
        height = if @clientHeight < document.body.clientHeight then @clientHeight else document.body.clientHeight
        $('div#' + panId).css 'height', height + 'px'
      if panViewWidthType == 'dynamic' or panViewHeightType == 'dynamic'
        bounds = null
        bounds = new GetElementBounds(eThis)
        mouseStartX = 0
        mouseStartY = 0
        mouseDropX = 0
        mouseDropY = 0
        $('div#' + panMaskId).css('left', 0 + 'px').css 'top', 0 + 'px'
      return
    $('div#' + panId).mousedown (e) ->
      mouseState = 'down'
      me = new MouseEvent(e)
      mouseStartX = me.x
      mouseStartY = me.y
      me = null
      $(this).css 'cursor', 'move'
      false
    $('div#' + panId).mouseup (e) ->
      mouseState = 'up'
      mouseDropX = parseInt($('div#' + panMaskId).get(0).style.left)
      mouseDropY = parseInt($('div#' + panMaskId).get(0).style.top)
      $(this).css 'cursor', 'default'
      return
    $(document.body).mousemove (e) ->
      me = new MouseEvent(e)
      ePan = $('div#' + panId).get(0)
      # simple bound check.
      if me.x < ePan.offsetLeft or me.x > ePan.offsetLeft + width or me.y < ePan.offsetTop or me.y > ePan.offsetTop + height
        mouseState = 'up'
      if mouseState == 'down'
        iLeft = mouseDropX - (mouseStartX - (me.x))
        iTop = mouseDropY - (mouseStartY - (me.y))
        if iLeft < bounds.minX
          iLeft = bounds.minX
        else if iLeft > bounds.maxX
          iLeft = bounds.maxX
        if iTop < bounds.minY
          iTop = bounds.minY
        else if iTop > bounds.maxY
          iTop = bounds.maxY
        $('div#' + panMaskId).css('left', iLeft + 'px').css 'top', iTop + 'px'
      me = null
      false
    return

