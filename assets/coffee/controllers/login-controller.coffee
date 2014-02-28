define (require) ->
  'use strict'

  require 'jquery-cookie'

  $          = require 'jquery'
  Chaplin    = require 'chaplin'
  utils      = require 'lib/utils'

  Controller = require 'controllers/base/controller'


  class LoginController extends Controller

    login: (params) ->
      @adjustTitle 'Login'

      (fetch = (again) =>
        Chaplin.mediator.user.fetch
          success: (model) =>
            if not Chaplin.mediator.redirectUrl then @redirectTo 'hello_home'
            else @redirectTo url: Chaplin.mediator.redirectUrl

          error: (model, error) -> console.error 'error requesting', error
          denied: ->
            if not again then utils.pageTransition $('#login'), 'top'
            $(document).one 'loginsuccess', -> fetch true
      )()

    logout: (params) ->
      user = Chaplin.mediator.user

      if user?.get 'loggedin'
        try
          user.logout()
        catch e
          @publishEvent '!error', e

      else
        @redirectTo 'hello_home'


    validate: (params) ->
      console.info "Received auth token from server", params.token
      Chaplin.mediator.authToken = params.token
      $.cookie 'token', params.token, path: '/'

      currentUser = Chaplin.mediator.user
      currentUser.fetch()
        .done =>
          if not Chaplin.mediator.redirectUrl then @redirectTo 'hello_home'
          else @redirectTo url: Chaplin.mediator.redirectUrl
        .fail (error) ->
          console.info "failed to login:", error



