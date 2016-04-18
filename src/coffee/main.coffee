require '../stylus/main.styl'
domready = require 'domready'

$id = document.getElementById.bind document
$tag = document.getElementsByTagName.bind document
ratio = 1.413684211

domready ->
  window.addEventListener 'resize', onResize
  onResize()
  document.body.dataset.philosophy = 'absolutism'

onResize = ->
  if window.innerHeight / window.innerWidth > ratio
    $tag('main')[0].style.height = "#{window.innerWidth * ratio * 0.95}px"
    $tag('main')[0].style.width = "#{window.innerWidth * 0.95}px"
  else
    $tag('main')[0].style.height = "#{window.innerHeight * 0.95}px"
    $tag('main')[0].style.width = "#{window.innerHeight / ratio * 0.95}px"
