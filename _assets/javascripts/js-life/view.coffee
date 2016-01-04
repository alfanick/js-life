class Life.View
  constructor: (@element) ->


class Life.View.Controls extends Life.View


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

    @draw()


  handle_events: () ->
    @element.addEventListener('mousedown', @on_click.bind(this), false)
    @element.addEventListener('mousemove', @on_move.bind(this), false)
    @element.addEventListener('mouseout', @on_out.bind(this), false)


  on_click: (event) ->
    return unless @interactive

    x = Math.floor((event.pageX - @offset[0]) / @cell_size[0])
    y = Math.floor((event.pageY - @offset[1]) / @cell_size[1])

    @board.set([x, y], @rules.next(@board.at([x, y])))
    @draw()


  on_move: (event) ->
    return unless @interactive

    x = Math.floor((event.pageX - @offset[0]) / @cell_size[0])
    y = Math.floor((event.pageY - @offset[1]) / @cell_size[1])

    @temporary_position = [x, y]
    @draw()


  on_out: (event) ->
    return unless @interactive

    @temporary_position = null
    @draw()


  draw: () ->
    for x in [0...@board.size[0]]
      for y in [0...@board.size[1]]
        @context.fillStyle = @colors[@board.at([x, y])]
        @context.fillRect(x * @cell_size[0], y * @cell_size[1],
          @cell_size[0], @cell_size[1])

    if @temporary_position
      @context.fillStyle = "rgba(255, 0, 255, 0.3)"
      @context.fillRect(@temporary_position[0] * @cell_size[0], @temporary_position[1] * @cell_size[1], @cell_size[0], @cell_size[1])


  update_size: () ->
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
      c = ((max_index - index) * 255 / max_index).toString(16)
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
