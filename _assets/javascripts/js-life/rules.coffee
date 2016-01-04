class Life.Rules
  initial_state: null
  states: {}
  next_states:
    null: null

  next: (state) ->
    return @next_states[state]

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

    if state == @states.alive and  2 <= alive <= 3
      return @states.alive

    return @states.dead


class Life.Rules.March extends Life.Rules
  initial_state: 0
  states:
    dormant: 0
    active: 1
  next_states:
    0: 1
    1: 0


  step: (state, neighbours) ->
    active = neighbours.count(@states.active)

    if state == @states.active and active >= 4
      return @states.dormant

    if state == @states.dormant and active == 2
      return @states.active

    if active == 3
      return @states.active

    return @states.dormant


class Life.Rules.Invasion extends Life.Rules
  initial_state: 0
  states:
    dormant: 0
    active: 1
    subactive: 2
  next_states:
    0: 1
    1: 2
    2: 0


  step: (state, neighbours) ->
    active = neighbours.count(@states.active)
    subactive = neighbours.count(@states.subactive)
    at_least_active = active + subactive

    if state == @states.active and at_least_active >= 3
      return @states.subactive

    if state == @states.dormant and at_least_active >= 3
      return @states.active

    if state == @states.active and 1 <= at_least_active <= 2
      return @states.active

    return @states.dormant

