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
    @controller.size "Olbrzymia (320x320)", [320, 320]

    # game = new Life.Game.Conway([10, 10])
    @controller.builtin_states = {"Pi Heptomino":{"generation":0,"env":["Oryginalna Gra w Życie Conway'a","Gwiazda (Moora)","Prostokąt (ze ścianami)","Ogromna (160x160)"],"compressed_matrix":[[78,78,1],[78,79,1],[79,79,1],[79,80,1],[80,79,1]]},"R Pentomino":{"generation":0,"env":["Oryginalna Gra w Życie Conway'a","Gwiazda (Moora)","Prostokąt (ze ścianami)","Duża (80x80)"],"compressed_matrix":[[39,39,1],[39,40,1],[40,39,1],[41,39,1],[42,40,1]]},"Conway Demo":{"generation":0,"env":["Oryginalna Gra w Życie Conway'a","Gwiazda (Moora)","Torus (bez ścian)","Duża (80x80)"],"compressed_matrix":[[7,67,1],[8,67,1],[8,68,1],[9,67,1],[9,68,1],[10,68,1],[38,35,1],[38,36,1],[38,37,1],[44,46,1],[45,45,1],[45,47,1],[46,46,1],[47,29,1],[47,30,1],[48,29,1],[48,30,1],[54,40,1],[55,38,1],[55,39,1],[56,40,1],[56,41,1],[57,39,1],[68,16,1],[68,17,1],[68,18,1],[69,16,1],[69,19,1],[70,16,1],[71,16,1],[72,17,1],[76,23,1],[76,24,1],[77,23,1],[77,25,1],[78,23,1]]},"Gliders by the Dozen":{"generation":0,"env":["Oryginalna Gra w Życie Conway'a","Gwiazda (Moora)","Torus (bez ścian)","Duża (80x80)"],"compressed_matrix":[[38,38,1],[38,39,1],[38,40,1],[39,38,1],[41,40,1],[42,38,1],[42,39,1],[42,40,1]]},"Thunderbird":{"generation":0,"env":["Oryginalna Gra w Życie Conway'a","Gwiazda (Moora)","Torus (bez ścian)","Duża (80x80)"],"compressed_matrix":[[37,38,1],[37,39,1],[37,40,1],[39,39,1],[40,39,1],[41,39,1]]}}

  run: () ->
    @controller.reset("Oryginalna Gra w Życie Conway'a", "Gwiazda (Moora)", "Prostokąt (ze ścianami)", "Średnia (40x40)")


