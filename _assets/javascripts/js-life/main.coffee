#= require_self
#= require_tree .

class window.Life
  constructor: () ->
    @controller = new Life.Controller()

    @controller.rule "Original Conway", Life.Rules.Conway
    @controller.rule "March", Life.Rules.March
    @controller.rule "Invasion", Life.Rules.Invasion
    @controller.rule "HighLife", Life.Rules.Conway.rules([2,3], [3,6])
    @controller.rule "Seeds", Life.Rules.Conway.rules([], [2])
    @controller.rule "Amoeba", Life.Rules.Conway.rules([1,3,5,8], [3,5,7])
    @controller.rule "Replicator", Life.Rules.Conway.rules([1,3,5,7], [1,3,5,7])

    @controller.neighbourhood "Neumann (4-cross)", Life.Neighbourhood.Cross
    @controller.neighbourhood "Moore (8-star)", Life.Neighbourhood.Star

    @controller.board "Rectangle (bounded)", Life.Board
    @controller.board "Torus (folded)", Life.Board.Folded

    @controller.size "Extra Small (10x10)", [10, 10]
    @controller.size "Small (20x20)", [20, 20]
    @controller.size "Medium (40x40)", [40, 40]
    @controller.size "Large (80x80)", [80, 80]
    @controller.size "Huge (160x160)", [160, 160]

    # game = new Life.Game.Conway([10, 10])

  run: () ->
    @controller.reset("Original Conway", "Moore (8-star)", "Rectangle (bounded)", "Medium (40x40)")


