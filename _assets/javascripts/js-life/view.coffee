class Life.View
  constructor: (@element) ->


class Life.View.Controls extends Life.View
  constructor: (element, @controller) ->
    super(element)

    @rules = element.elements.namedItem('rules')
    @neighbourhood = element.elements.namedItem('neighbourhood')
    @size = element.elements.namedItem('size')
    @board_type = element.elements.namedItem('board_type')
    @fps = element.elements.namedItem('fps')
    @buttons =
      'step': element.elements.namedItem('step')
      'start': element.elements.namedItem('start')
      'pause': element.elements.namedItem('pause')
      'reset': element.elements.namedItem('reset')

    @update_generation(0)
    @update_selects()
    @handle_events()


  handle_events: () ->
    @buttons['step'].addEventListener 'click', (e) =>
      e.preventDefault()
      @controller.step()
      return false

    @buttons['start'].addEventListener 'click', (e) =>
      e.preventDefault()
      @controller.animate(@controller.fps)
      @buttons['pause'].disabled = false
      @buttons['start'].disabled = true
      return false

    @buttons['pause'].addEventListener 'click', (e) =>
      e.preventDefault()
      @controller.stop_animation()
      @buttons['start'].disabled = false
      @buttons['pause'].disabled = true
      return false

    @buttons['reset'].addEventListener 'click', (e) =>
      e.preventDefault()
      @build(e)
      return false

    @fps.addEventListener 'change', (e) =>
      @controller.fps = parseFloat(@fps.value)
      if @controller.animation
        @controller.stop_animation()
        @controller.animate(@controller.fps)

    @rules.addEventListener('change', @build.bind(this))
    @neighbourhood.addEventListener('change', @build.bind(this))
    @size.addEventListener('change', @build.bind(this))
    @board_type.addEventListener('change', @build.bind(this))


  update_generation: (g) ->
    @buttons['step'].innerHTML = "Step (#{g})"


  build: (e) ->
    @controller.reset(@rules.value, @neighbourhood.value, @board_type.value, @size.value)
    @buttons['start'].disabled = false
    @buttons['pause'].disabled = true


  update_selects: (ri, ni, bi, si) ->
    build_option = (text, index) ->
      option = document.createElement('option')
      option.value = option.text = text
      if text == index
        option.selected = true
      return option

    @rules.innerHTML = ''
    for name, _ of @controller.rules
      @rules.add(build_option(name, ri))

    @neighbourhood.innerHTML = ''
    for name, _ of @controller.neighbourhoods
      @neighbourhood.add(build_option(name, ni))

    @size.innerHTML = ''
    for name, _ of @controller.sizes
      @size.add(build_option(name, si))

    @board_type.innerHTML = ''
    for name, _ of @controller.boards
      @board_type.add(build_option(name, bi))

    @fps.innerHTML = ''
    for f in ['60', '30', '15', '2', '1', '0.5', '0.2', '0.1', '0.05']
      @fps.add(build_option(f, "" + @controller.fps))



class Life.View.Board extends Life.View
  scale: 1.0
  offset: [0, 0]
  temporary_position: null


  constructor: (element, @board, @rules, @interactive) ->
    super(element)

    @context = element.getContext('2d')

    @update_colors()
    @update_size()

    @handle_events() if @interactive

    window.requestAnimationFrame(@draw.bind(this))


  handle_events: () ->
    @element.addEventListener('mousedown', @on_click.bind(this), false)
    @element.addEventListener('mousemove', @on_move.bind(this), false)
    @element.addEventListener('mouseout', @on_out.bind(this), false)
    window.addEventListener 'resize', (e) =>
      @update_size()
      window.requestAnimationFrame(@draw.bind(this))


  on_click: (event) ->
    return unless @interactive

    x = Math.floor((event.pageX - @offset[0]) / @cell_size[0])
    y = Math.floor((event.pageY - @offset[1]) / @cell_size[1])

    @board.set([x, y], @rules.next(@board.at([x, y])))
    window.requestAnimationFrame(@draw.bind(this))


  on_move: (event) ->
    return unless @interactive

    x = Math.floor((event.pageX - @offset[0]) / @cell_size[0])
    y = Math.floor((event.pageY - @offset[1]) / @cell_size[1])

    @temporary_position = [x, y]
    window.requestAnimationFrame(@draw.bind(this))


  on_out: (event) ->
    return unless @interactive

    @temporary_position = null
    window.requestAnimationFrame(@draw.bind(this))


  draw: () ->
    @context.clearRect(0, 0, @element.width, @element.height)

    for x in [0...@board.size[0]]
      for y in [0...@board.size[1]]
        @context.fillStyle = @colors[@board.at([x, y])]
        @context.fillRect(x * @cell_size[0], y * @cell_size[1],
          @cell_size[0], @cell_size[1])

    if @temporary_position
      @context.fillStyle = "rgba(255, 0, 255, 0.3)"
      @context.fillRect(@temporary_position[0] * @cell_size[0], @temporary_position[1] * @cell_size[1], @cell_size[0], @cell_size[1])

    @context.fillStyle = "rgba(255, 0, 255, 0.1)"
    @context.fillRect(@board.size[0]/2 * @cell_size[0] - 1, @board.size[1]/2 * @cell_size[1] - 1, 2, 2)


  update_size: () ->
    h = Math.min(Math.max(window.innerHeight, document.getElementById('aside').clientHeight), 0.7 * window.innerWidth)
    @element.style.width = "#{h}px"
    @element.style.height = "#{h}px"

    @hidpi_fix()

    box = @element.getBoundingClientRect()

    @cell_size = [
      box.width / @board.size[0],
      box.height / @board.size[1]
    ]

    @offset = [
      box.left,
      box.top
    ]


  update_colors: () ->
    @colors = {}
    max_index = Object.keys(@rules.states).length - 1
    index = 0

    for _, state of @rules.states
      c = Math.floor((max_index - index) * 255 / max_index).toString(16)
      @colors[state] = "##{c}#{c}#{c}"
      index++


  hidpi_fix: () ->
    return unless window.devicePixelRatio
    box = @element.getBoundingClientRect()
    ratio = window.devicePixelRatio

    @element.setAttribute('width', box.width * ratio)
    @element.setAttribute('height', box.height * ratio)

    @element.style.width = "#{box.width}px"
    @element.style.height = "#{box.height}px"

    @context.scale(ratio, ratio)

    @scale = ratio
