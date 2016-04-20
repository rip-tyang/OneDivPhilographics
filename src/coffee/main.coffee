require '../stylus/main.styl'
domready = require 'domready'

$id = document.getElementById.bind document
$tag = document.getElementsByTagName.bind document
$main = null
$title = null
$desc = null
$popout = null
$black = null
ratio = 1.413684211

delay = (time, func) ->
  setTimeout func, time

arrPhilosophy = [
  'absolutism'
  'absurdism'
  'altruism'
]

arrTitle = arrPhilosophy.map (e) ->
  e.charAt(0).toUpperCase() + e.slice(1) + '.'

arrDesc = [
  'The position that within a particular school of thought, all different perspectives are either absolutely true or absolutely false.'
  'The contention that the attempts of man to find meaning in universe will ultimately fail because no such meaning exists.'
  'The practise and principle of using actions to benefit others, expecting nothign in return.'
]

currIdx = 0

domready ->
  $main = $tag('main')[0]
  $title = $id('title')
  $desc = $id('desc')
  $black = $id('black')
  $popout = $id('popout')
  window.addEventListener 'resize', onResize
  window.addEventListener 'keydown', (e) ->
    switch e.keyCode
      when 39 then nextP()
      when 37 then prevP()
  update()
  onResize()
  delay 500, showPopout
  delay 2500, hidePopout


onResize = ->
  if window.innerHeight / window.innerWidth > ratio
    $main.style.height = "#{window.innerWidth * ratio * 0.95}px"
    $main.style.width = "#{window.innerWidth * 0.95}px"
    document.documentElement.style.fontSize = "#{0.95*ratio}vw"
  else
    $main.style.height = "#{window.innerHeight * 0.95}px"
    $main.style.width = "#{window.innerHeight / ratio * 0.95}px"
    document.documentElement.style.fontSize = '0.95vh'

nextP = ->
  currIdx = (currIdx+1)%arrPhilosophy.length
  update()

prevP = ->
  currIdx = (currIdx+arrPhilosophy.length-1)%arrPhilosophy.length
  update()

update = ->
  $title.innerHTML = arrTitle[currIdx]
  $desc.innerHTML = arrDesc[currIdx]
  document.body.dataset.philosophy = arrPhilosophy[currIdx]

showPopout = ->
  $black.style.opacity = 1
  $popout.style.opacity = 1

hidePopout = ->
  $black.style.opacity = 0
  $popout.style.opacity = 0
