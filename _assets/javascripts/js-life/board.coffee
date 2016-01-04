class Life.Board
  matrix: undefined


  constructor: (@size, @default_state = null) ->
    @reset()


  reset: () ->
    @matrix = new Array(@size[0]).fill(new Array(@size[1]).fill(@default_state))


  transform: (position) ->
    if 0 <= position[0] < @size[0] and 0 <= position[1] < @size[1]
      return position
    else
      return null


  at: (position) ->
    return @matrix[position[0]][position[1]]
