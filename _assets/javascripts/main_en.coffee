window.life = new Life
  "rule.conway": "Original Conway"
  "rule.march": "March"
  "rule.invasion": "Invasion"
  "rule.highlife": "HighLife"
  "rule.seeds": "Seeds"
  "rule.amoeba": "Amoeba"
  "rule.replicator": "Replicator"
  "neighbourhood.neumann": "Neumann (4-cross)"
  "neighbourhood.moore": "Moore (8-star)"
  "board.rectangle": "Rectangle (bounded)"
  "board.torus": "Torus (unbounded)"
  "size.xs": "Extra Small (10x10)"
  "size.s": "Small (20x20)"
  "size.m": "Medium (40x40)"
  "size.l": "Large (80x80)"
  "size.xl": "Huge (160x160)"
  "size.xxl": "Ultra Huge (320x320)"
  "prompt.save": "Saves are local. Name:"

document.addEventListener 'DOMContentLoaded', ->
  window.life.run()
