class Life.Neighbourhood
  vectors: []


  constructor: (@board) ->
    @position = [0, 0]


  of: (@position) ->
    return this


  each: (action) ->
    valid = 0

    for vector in @vectors
      position = @board.transform([
        @position[0] + vector[0],
        @position[1] + vector[1]
      ])

      continue unless position

      action(position)
      valid++

    return valid


  count: (state) ->
    count = 0

    @each (position) =>
      count++ if @board.at(position) == state

    return count


class Life.Neighbourhood.Cross extends Life.Neighbourhood
  vectors: [
    [-1,  0],
    [+1,  0],
    [ 0, -1],
    [ 0, +1]
  ]


class Life.Neighbourhood.Star extends Life.Neighbourhood
  vectors: [
    [-1,  0],
    [+1,  0],
    [ 0, -1],
    [ 0, +1],
    [-1, -1],
    [-1, +1],
    [+1, +1],
    [+1, -1]
  ]
