
define (require) ->
  'use strict'

  $           = require 'jquery'


  $.extend
    # http://aboutcode.net/2013/01/09/load-images-with-jquery-deferred.html
  	loadImage: (url) ->
      loadImage = (deferred) ->
        $image = $(new Image)

        $image.one 'load', -> deferred.resolve $image
        $image.one 'error', -> deferred.reject $image
        $image.one 'abort', -> deferred.reject $image

        $image.attr 'src', url

      $.Deferred(loadImage).promise()
