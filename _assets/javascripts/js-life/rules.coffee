class Life.Rules
  initial_state: null
  states: {}


  step: (state, neighbours) ->
    return state


class Life.Rules.Conway extends Life.Rules
  initial_state: 0
  states:
    dead: 0
    alive: 1


  step: (state, neighbours) ->
    alive = neighbours.of(position).count(@states.alive)

    if state == @states.dead and alive == 3
      return @states.alive
    else
      if 2 <= alive <= 3
        return @states.alive
      else
        return @states.dead

    return state

