define (require) ->
  'use strict'

  Chaplin     = require 'chaplin'

  Model       = require 'models/base/model'


  class Location extends Model
    _.extend @prototype, Chaplin.EventBroker

    urlRoot: 'location'

    defaults:
      lat:    null
      long:   null
      address:null
      parts:  null

    initialize: (options) ->
      @unset 'latlng'
      @set 'lat', options?.latlng?[0]
      @set 'long', options?.latlng?[1]
