#= require_self
#= require_tree .

class window.Life
  constructor: () ->
    @controller = new Life.Controller()
    # game = new Life.Game.Conway([10, 10])

  run: () ->
    @controller.run()


