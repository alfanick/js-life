class Life.Controller
  animation: null
  rules: {}
  neighbourhoods: {}
  sizes: {}


  rule: (n, v) ->
    @rules[n] = v


  neighbourhood: (n, v) ->
    @neighbourhoods[n] = v


  size: (n, v) ->
    @sizes[n] = v


  run: ->
    @game = Life.Game.build([10, 10], Life.Neighbourhood.Star, Life.Rules.Conway)

    # @game.board.set([2,1], 1)
    # @game.board.set([2,2], 1)
    # @game.board.set([2,3], 1)

    @controls_view = new Life.View.Controls(document.getElementById('controls'))
    @board_view = new Life.View.Board(document.getElementById('board'), @game.board, @game.rules, true)
    @animate(0.1)


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


