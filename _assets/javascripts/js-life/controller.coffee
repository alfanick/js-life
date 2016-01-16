class Life.Controller
  animation: null
  rules: {}
  neighbourhoods: {}
  sizes: {}
  boards: {}
  builtin_states: {}
  fps: 1


  rule: (n, v) ->
    @rules[n] = v


  neighbourhood: (n, v) ->
    @neighbourhoods[n] = v


  size: (n, v) ->
    @sizes[n] = v


  board: (n, v) ->
    @boards[n] = v


  constructor: (@id) ->
    @controls_view = new Life.View.Controls(document.getElementById('controls'), this)
    @board_view = new Life.View.Board(document.getElementById('board'), true)


  save_state: (name) ->
    states = @saved()
    states[name] =
      generation: @game.generation
      env: @selects

    compressed_matrix = @game.board.compress_matrix()

    if compressed_matrix.length * 3 < (@game.board.size[0] * @game.board.size[1])
      states[name]["compressed_matrix"] = compressed_matrix
    else
      states[name]["matrix"] = @game.board.matrix
    localStorage.setItem("saved_games_#{@id}", JSON.stringify(states))
    @controls_view.update_saves()


  load_state: (name) ->
    @stop_animation()
    saved = @saved()
    state = saved[name]
    state = @builtin_states[name] unless state
    return unless state

    @game = Life.Game.build(@boards[state.env[2]], @sizes[state.env[3]], @neighbourhoods[state.env[1]], @rules[state.env[0]])
    @game.generation = state.generation

    if state.compressed_matrix
      @game.board.decompress_matrix(state.compressed_matrix)
    else
      @game.board.matrix = state.matrix

    @controls_view.update_selects(state.env[0], state.env[1], state.env[2], state.env[3])
    @controls_view.update_generation(@game.generation)

    @board_view.reset(@game.board, @game.rules)


  saved: ->
    JSON.parse(localStorage.getItem("saved_games_#{@id}")) or {}


  reset: (ri, ni, bi, si) ->
    @stop_animation()
    @selects = [ri, ni, bi, si]
    @controls_view.update_selects(ri, ni, bi, si)
    @controls_view.update_generation(0)

    @game = Life.Game.build(@boards[bi], @sizes[si], @neighbourhoods[ni], @rules[ri])
    @board_view.reset(@game.board, @game.rules)


  stop_animation: () ->
    window.cancelAnimationFrame(@animation)
    @animation = null


  animate: (fps) ->
    @stop_animation()

    interval = 1000.0 / fps
    last_run = Date.now()

    animator = =>
      @animation = window.requestAnimationFrame(animator.bind(this))

      now = Date.now()
      return if (now - last_run) < interval
      last_run = now

      @step()

    @animation = window.requestAnimationFrame(animator.bind(this))


  step: () ->
    @game.step()

    @board_view.board = @game.board
    @board_view.draw()
    @controls_view.update_generation(@game.generation)


