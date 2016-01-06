class Life.Game
  generation: 0
  boards: [null, null]
  board: null
  id: null


  constructor: (board, @size, @neighbours, @rules) ->
    @id = Math.random().toString(36).slice(-5)
    @boards = [
      new board(@size, @rules.initial_state),
      new board(@size, @rules.initial_state)
    ]
    @switch_board(@boards[0])


  step: () ->
    current = if @board == @boards[0] then @boards[1] else @boards[0]
    previous = @board

    for x in [0...@size[0]]
      for y in [0...@size[1]]
        position = [x, y]
        new_state = @rules.step(previous.at(position), @neighbours.of(position))
        current.set(position, new_state)

    @switch_board(current)
    @generation++


  switch_board: (new_board) ->
    @board = new_board
    @neighbours.on(new_board)


  @build: (board_class, size, neighbourhood, rules_class) ->
    rules = new rules_class()
    neighbours = new neighbourhood()

    return new Life.Game(board_class, size, neighbours, rules)


