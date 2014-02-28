define [
  'chaplin'
  'views/footer-view'
  'views/skeleton-view'
  'views/imprint-view'
  'views/login-view'
  'views/error-view'
], (Chaplin, FooterView, SekeltonView, ImprintView, LoginView, ErrorView) ->
  'use strict'

  class Controller extends Chaplin.Controller
    beforeAction: (params, route) ->
      @reuse 'footer', FooterView, model: Chaplin.mediator.user
      @reuse 'site', SekeltonView
      @reuse 'imprint', ImprintView, region: 'imprint'
      @reuse 'login', LoginView, region: 'login'
      @reuse 'error', ErrorView, region: 'error'



