window.life = new Life
  "rule.conway": "Oryginalna Gra w życie Conway'a"
  "rule.march": "Marsz"
  "rule.invasion": "Inwazja"
  "rule.highlife": "HighLife"
  "rule.seeds": "Nasiona"
  "rule.amoeba": "Ameba"
  "rule.replicator": "Replikator"
  "neighbourhood.neumann": "Krzyż (Neumanna)"
  "neighbourhood.moore": "Gwiaza (Moora)"
  "board.rectangle": "Prostokąt (ze ścianami)"
  "board.torus": "Torus (bez ścian)"
  "size.xs": "Bardzo mała (10x10)"
  "size.s": "Mała (20x20)"
  "size.m": "Średnia (40x40)"
  "size.l": "Duża (80x80)"
  "size.xl": "Ogromna (160x160)"
  "size.xxl": "Olbrzymia (320x320)"
  "prompt.save": "Zapisy są lokalne. Nazwa:"

document.addEventListener 'DOMContentLoaded', ->
  window.life.run()
