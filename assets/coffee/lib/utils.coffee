
define (require) ->
  'use strict'

  _           = require 'underscore'
  Modernizr   = require 'modernizr'
  Chaplin     = require 'chaplin'

  # Application-specific utilities
  # ------------------------------

  # Delegate to Chaplin’s utils module
  utils = Chaplin.utils.beget Chaplin.utils

  # Add additional application-specific properties and methods

  _(utils).extend
    pageTransition: ($in, dir) ->

      $out = $('.pt-page.pt-page-current').first()

      if not $in.length or $in.is $out then return

      animEndEventNames =
        'WebkitAnimation' : 'webkitAnimationEnd'
        'OAnimation' : 'oAnimationEnd'
        'msAnimation' : 'MSAnimationEnd'
        'animation' : 'animationend'
      animEndEventName = animEndEventNames[ Modernizr.prefixed( 'animation' ) ]
      support = Modernizr.cssanimations
      endCurrPage = endNextPage = false

      onEndAnimation = ($out, $in) ->
        endCurrPage = endNextPage = false
        resetPage $out, $in

        $in.trigger 'inview'
        $out.trigger 'outview'

      resetPage = ($out, $in) ->
        $out.removeClass (index, css) -> return (css.match (/\pt-page-move\S+/g) || [])?.join(' ')
        $out.removeClass 'pt-page-current pt-page-ontop'

        $in.removeClass (index, css) -> return (css.match (/\pt-page-move\S+/g) || [])?.join(' ')
        $in.addClass 'pt-page-ontop'

      switch dir

        when "right"
          outClass = 'pt-page-moveToLeft'
          inClass = 'pt-page-moveFromRight'

        when "left"
          outClass = 'pt-page-moveToRight'
          inClass = 'pt-page-moveFromLeft'

        when "bottom"
          outClass = 'pt-page-moveToTop'
          inClass = 'pt-page-moveFromBottom'

        when "top"
          outClass = 'pt-page-moveToBottom'
          inClass = 'pt-page-moveFromTop'


      $in.addClass 'pt-page-current'

      $out.addClass(outClass).on animEndEventName, () ->
        $out.off animEndEventName
        endCurrPage = true
        if endNextPage then onEndAnimation $out, $in

      $in.addClass(inClass).on animEndEventName, () ->
        $in.off animEndEventName
        endNextPage = true
        if endCurrPage or not $out.length then onEndAnimation $out, $in

      if !support then onEndAnimation $out, $in

    formatFileSize: (bytes)->
      if typeof bytes is not 'number' then return ''

      if bytes >= 1000000000 then return "#{(bytes / 1000000000).toFixed(2)} GB"
      else if bytes >= 1000000 then return "#{(bytes / 1000000).toFixed(2)} MB"
      else if bytes >= 1000 then return "#{(bytes / 1000).toFixed(2)} KB"

    uuid4: () ->
      "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace /[xy]/g, (c) ->
        r = Math.random()*16|0
        v = if c is 'x' then r else r&0x3|0x8
        v.toString(16)

  utils
