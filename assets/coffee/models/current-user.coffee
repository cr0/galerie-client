define [
  'models/user'
], (User) ->
  'use strict'

  class CurrentUser extends User

    defaults:
      loggedin: false

    # current user has fixed location on the server
    url: -> return @urlRoot + '/me'

    initialize: ->
      super
      @on 'change:loggedin', (model) =>
        if model.get 'loggedin' then @publishEvent 'loggedin', model
        else @publishEvent 'loggedout', model

      @subscribeEvent 'loggedout', => @unsubscribeAllEvents()

      @subscribeEvent 'loggedin', (model) -> console.log "current user has id ##{model.id}"
      @subscribeEvent 'loggedout', (model) -> console.log "current user logged out"

    dispose: ->
      console.log 'ignore dispose'

    logout: ->
      $.ajax
        type: 'POST'
        url: '/auth/logout'
        success: =>
          console.log "logged out", @
          @set 'loggedin', false
        error: (model, error) ->
          throw new Error "error while logging out user #{error}"


  new CurrentUser