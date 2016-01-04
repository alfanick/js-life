#= require_self
#= require_tree .

class window.Life
  constructor: () ->
    rules = new Life.Rules.Conway()
    alert rules.initial_state
    board = new Life.Board([2, 2], rules.initial_state)
    neighbours = new Life.Neighbourhood.Cross(board)

    alert neighbours.of([1,1]).count(rules.states.dead)

