#= require ./js-life/main

window.life = new Life

document.addEventListener 'DOMContentLoaded', ->
  window.life.run()
