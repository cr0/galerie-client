define (require) ->
  'use strict'

  Chaplin     = require 'chaplin'

  Model       = require 'models/base/model'


  class User extends Model
    _.extend @prototype, Chaplin.EventBroker

    urlRoot: 'user'

    defaults:
      name:       null
      username:   null
      email:      null
      loggedin:   false
      reputation: 0

    reputationList:
      picture:
        add:      2

    reputation: (which) ->
      points = 0

      switch which
        when 'picture:add' then points = @reputationList['picture']['add']

      @set 'reputation', @get('reputation') + points
