class Life.Controller
  animation: null
  rules: {}
  neighbourhoods: {}
  sizes: {}
  boards: {}
  fps: 1


  rule: (n, v) ->
    @rules[n] = v


  neighbourhood: (n, v) ->
    @neighbourhoods[n] = v


  size: (n, v) ->
    @sizes[n] = v


  board: (n, v) ->
    @boards[n] = v


  constructor: ->
    @controls_view = new Life.View.Controls(document.getElementById('controls'), this)


  reset: (ri, ni, bi, si) ->
    @stop_animation()
    @controls_view.update_selects(ri, ni, bi, si)
    @controls_view.update_generation(0)

    @game = Life.Game.build(@boards[bi], @sizes[si], @neighbourhoods[ni], @rules[ri])
    @board_view = new Life.View.Board(document.getElementById('board'), @game.board, @game.rules, true)


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


