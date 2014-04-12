$ ->
  currentImage = 2

  changeHeaderImage = ->
    $('.homepage-top').css 'background-image', "url(/assets/mi_background_#{currentImage}.jpg)"
    if currentImage == 3
      currentImage = 1
    else
      currentImage++

  setInterval ->
    changeHeaderImage()
  , 5000
