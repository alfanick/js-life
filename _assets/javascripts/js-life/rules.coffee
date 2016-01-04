class Life.Rules
  initial_state: null
  states: {}

  next: (state) ->
    return state

  step: (state, neighbours) ->
    return state


class Life.Rules.Conway extends Life.Rules
  initial_state: 0
  states:
    dead: 0
    alive: 1

  next_states:
    0: 1
    1: 0


  step: (state, neighbours) ->
    alive = neighbours.count(@states.alive)

    if state == @states.dead and alive == 3
      return @states.alive
    else if state == @states.alive and  2 <= alive <= 3
      return @states.alive

    return @states.dead


  next: (state) ->
    return @next_states[state]

