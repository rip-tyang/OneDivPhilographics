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
xDown = null
yDown = null

delay = (time, func) ->
  setTimeout func, time


handleTouchStart = (evt) ->
  xDown = evt.touches[0].clientX
  yDown = evt.touches[0].clientY

handleTouchMove = (evt) ->
  return if !xDown || !yDown

  xUp = evt.touches[0].clientX
  yUp = evt.touches[0].clientY

  xDiff = xDown - xUp
  yDiff = yDown - yUp

  if (Math.abs(xDiff) > Math.abs(yDiff))
    if xDiff > 0
      prevP()
    else
      nextP()
  else
    if yDiff > 0
        # up swipe
    else
        # down swipe
  # reset
  xDown = null
  yDown = null

arrPhilosophy = [
  'absolutism'
  'absurdism'
  'altruism'
  'relativism'
  'historicism'
  'anarchism'
]

arrTitle = arrPhilosophy.map (e) ->
  e.charAt(0).toUpperCase() + e.slice(1) + '.'

arrDesc = [
  'The position that within a particular school of thought, all different perspectives are either absolutely true or absolutely false.'
  'The contention that the attempts of man to find meaning in universe will ultimately fail because no such meaning exists.'
  'The practise and principle of using actions to benefit others, expecting nothign in return.'
  'The assertion that no belief can be said to have absolute truth, having value only within a certain context or frame of reference.'
  'The theory that to understand a historical event, you must understand the philosophical context that it took place in, rather than explain it with supposedly timeless or fundamental ideas.'
  'A range of views that oppose the idea of the state as a means of governance, instead advocating a society based on a non-hierachical relationships.'
]

currIdx = 5

domready ->
  $main = $tag('main')[0]
  $title = $id('title')
  $desc = $id('desc')
  $black = $id('black')
  $popout = $id('popout')
  window.addEventListener 'touchstart', handleTouchStart, false
  window.addEventListener 'touchmove', handleTouchMove, false
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
  delay 500, ->
    $black.style.display = 'none'
    $popout.style.display = 'none'
