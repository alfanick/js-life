#= require_self
#= require ./board
#= require ./controller
#= require ./game
#= require ./neighbourhood
#= require ./rules
#= require ./view

class window.Life
  constructor: (t) ->
    @controller = new Life.Controller()
    @controller.t = t

    @controller.rule "rule.conway", Life.Rules.Conway
    @controller.rule "rule.march", Life.Rules.March
    @controller.rule "rule.invasion", Life.Rules.Invasion
    @controller.rule "rule.highlife", Life.Rules.Conway.rules([2,3], [3,6])
    @controller.rule "rule.seeds", Life.Rules.Conway.rules([], [2])
    @controller.rule "rule.amoeba", Life.Rules.Conway.rules([1,3,5,8], [3,5,7])
    @controller.rule "rule.replicator", Life.Rules.Conway.rules([1,3,5,7], [1,3,5,7])

    @controller.neighbourhood "neighbourhood.neumann", Life.Neighbourhood.Cross
    @controller.neighbourhood "neighbourhood.moore", Life.Neighbourhood.Star

    @controller.board "board.rectangle", Life.Board
    @controller.board "board.torus", Life.Board.Folded

    @controller.size "size.xs", [10, 10]
    @controller.size "size.s", [20, 20]
    @controller.size "size.m", [40, 40]
    @controller.size "size.l", [80, 80]
    @controller.size "size.xl", [160, 160]
    @controller.size "size.xxl", [320, 320]

    @controller.builtin_states = {"Pi Heptomino":{"generation":0,"env":["rule.conway","neighbourhood.moore","board.rectangle","size.xl"],"compressed_matrix":[[78,78,1],[78,79,1],[79,79,1],[79,80,1],[80,79,1]]},"R Pentomino":{"generation":0,"env":["rule.conway","neighbourhood.moore","board.rectangle","size.l"],"compressed_matrix":[[39,39,1],[39,40,1],[40,39,1],[41,39,1],[42,40,1]]},"Conway Demo":{"generation":0,"env":["rule.conway","neighbourhood.moore","board.torus","size.xl"],"compressed_matrix":[[7,67,1],[8,67,1],[8,68,1],[9,67,1],[9,68,1],[10,68,1],[38,35,1],[38,36,1],[38,37,1],[44,46,1],[45,45,1],[45,47,1],[46,46,1],[47,29,1],[47,30,1],[48,29,1],[48,30,1],[54,40,1],[55,38,1],[55,39,1],[56,40,1],[56,41,1],[57,39,1],[68,16,1],[68,17,1],[68,18,1],[69,16,1],[69,19,1],[70,16,1],[71,16,1],[72,17,1],[76,23,1],[76,24,1],[77,23,1],[77,25,1],[78,23,1]]},"Gliders by the Dozen":{"generation":0,"env":["rule.conway","neighbourhood.moore","board.torus","size.l"],"compressed_matrix":[[38,38,1],[38,39,1],[38,40,1],[39,38,1],[41,40,1],[42,38,1],[42,39,1],[42,40,1]]},"Thunderbird":{"generation":0,"env":["rule.conway","neighbourhood.moore","board.torus","size.l"],"compressed_matrix":[[37,38,1],[37,39,1],[37,40,1],[39,39,1],[40,39,1],[41,39,1]]}}

  run: () ->
    @controller.reset("rule.conway", "neighbourhood.moore", "board.rectangle", "size.m")


