class Life.Board
  matrix: undefined


  constructor: (@size, @default_state = null) ->
    @reset()


  reset: () ->
    @matrix = []

    for x in [0...@size[0]]
      @matrix[x] = []
      for y in [0...@size[1]]
        @matrix[x][y] = @default_state


  transform: (position) ->
    if 0 <= position[0] < @size[0] and 0 <= position[1] < @size[1]
      return position
    else
      return null


  at: (position) ->
    return @matrix[position[0]][position[1]]


  set: (position, state) ->
    @matrix[position[0]][position[1]] = state
    return this


class Life.Board.Folded extends Life.Board
  transform: (position) ->
    transformed = [position[0] % @size[0], position[1] % @size[1]]
    transformed[0] += @size[0] if transformed[0] < 0
    transformed[1] += @size[1] if transformed[1] < 0

    return transformed
