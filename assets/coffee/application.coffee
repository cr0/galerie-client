define (require) ->
  'use strict'

  require 'jquery-cookie'

  _           = require 'underscore'
  Backbone    = require 'backbone'
  Chaplin     = require 'chaplin'

  CurrentUser = require 'models/current-user'

  class Application extends Chaplin.Application
    title: 'node-galerie.'

    initialize: (options = {}) ->
      @setApiRoot options.apiRoot if options.apiRoot?
      console.info "Reusing authentication token #{$.cookie 'token'}" if $.cookie 'token'

      super


    initMediator: ->
      Chaplin.mediator.user = CurrentUser
      Chaplin.mediator.redirectUrl = null
      Chaplin.mediator.apiRoot = @apiRoot
      Chaplin.mediator.authToken = $.cookie 'token'

      super


    setApiRoot: (apiRoot) ->
      @apiRoot = apiRoot
      @apiRoot = "#{@apiRoot}/" unless /\/$/.test @apiRoot
      console.info "Using #{@apiRoot} as API backend"

      bbSync = Backbone.sync
      Backbone.sync = (method, model, options) =>
        options = _.extend options,
          url: @apiRoot + if _.isFunction(model.url) then model.url() else model.url
          beforeSend: (xhr) -> xhr.setRequestHeader 'Authorization', "Token token=#{Chaplin.mediator.authToken}"

        bbSync method, model, options
