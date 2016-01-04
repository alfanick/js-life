#= require_self
#= require_tree .

class window.Life
  constructor: () ->
    game = new Life.Game.Conway([10, 10])

