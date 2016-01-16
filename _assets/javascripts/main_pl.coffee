#= require ./js-life/main_pl

window.life = new Life

document.addEventListener 'DOMContentLoaded', ->
  window.life.run()
