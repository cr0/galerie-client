define [
  'chaplin'
  'controllers/base/controller'
], (Chaplin, Controller) ->
  'use strict'

  class AuthController extends Controller

    beforeAction: (params, route) ->
      super
      if not Chaplin.mediator.user?.get 'loggedin'
        console.info "Login required for page: #{route.path}"
        Chaplin.mediator.redirectUrl = route.path
        @redirectTo 'login_login'
