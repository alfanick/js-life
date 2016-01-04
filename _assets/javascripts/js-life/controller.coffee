class Life.Controller
  run: ->
    @controls_view = new Life.View.Controls(document.getElementById('controls'), this)
    @board_view = new Life.View.Board(document.getElementById('board'), this)
