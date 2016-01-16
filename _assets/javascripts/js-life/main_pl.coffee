#= require_self
#= require ./board
#= require ./controller
#= require ./game
#= require ./neighbourhood
#= require ./rules
#= require ./view

class window.Life
  constructor: () ->
    @controller = new Life.Controller("pl")

    @controller.rule "Oryginalna Gra w Życie Conway'a", Life.Rules.Conway
    @controller.rule "Marsz", Life.Rules.March
    @controller.rule "Inwazja", Life.Rules.Invasion
    @controller.rule "HighLife", Life.Rules.Conway.rules([2,3], [3,6])
    @controller.rule "Nasiona", Life.Rules.Conway.rules([], [2])
    @controller.rule "Ameba", Life.Rules.Conway.rules([1,3,5,8], [3,5,7])
    @controller.rule "Replikator", Life.Rules.Conway.rules([1,3,5,7], [1,3,5,7])
    @controller.rule "Żyj Wolnie lub Umrzyj", Life.Rules.Conway.rules([0], [2])

    @controller.neighbourhood "Krzyż (Neumanna)", Life.Neighbourhood.Cross
    @controller.neighbourhood "Gwiazda (Moora)", Life.Neighbourhood.Star

    @controller.board "Prostokąt (ze ścianami)", Life.Board
    @controller.board "Torus (bez ścian)", Life.Board.Folded

    @controller.size "Bardzo mała (10x10)", [10, 10]
    @controller.size "Mała (20x20)", [20, 20]
    @controller.size "Średnia (40x40)", [40, 40]
    @controller.size "Duża (80x80)", [80, 80]
    @controller.size "Ogromna (160x160)", [160, 160]

    # game = new Life.Game.Conway([10, 10])

  run: () ->
    @controller.reset("Oryginalna Gra w Życie Conway'a", "Gwiazda (Moora)", "Prostokąt (ze ścianami)", "Średnia (40x40)")


