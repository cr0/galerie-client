define (require) ->
  'use strict'

  $         = require 'jquery'
  Chaplin   = require 'chaplin'

  View      = require 'views/base/view'

  Template  = require 'templates/login'


  class LoginView extends View
    template:   Template

    initialize: () ->
      super

      #@delegate 'click', 'a', @onProviderClick


    getTemplateData: ->
      data = super
      data.apiRoot = data.apiRoot.replace('/api/', '')
      data.origin = 'http://localhost:3001' + Chaplin.utils.reverse 'login_validate'
      data

    onProviderClick: (e) ->
      e.preventDefault()
      window.open $(e.target).attr('href'), "Login", "width=700,height=550,resizable=no"
      false
