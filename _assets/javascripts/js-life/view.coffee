class Life.View
  constructor: (@element, @controller) ->


class Life.View.Controls extends Life.View


class Life.View.Board extends Life.View
  constructor: (element, controller) ->
    super

    @context = element.getContext('2d')
    @context.moveTo(0,0);
    @context.lineTo(200,100);
    @context.stroke();
