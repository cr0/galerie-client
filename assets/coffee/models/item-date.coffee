define (require) ->
  'use strict'

  Chaplin = require 'chaplin'
  Moment  = require 'moment'

  Model   = require 'models/base/model'


  class ItemDate extends Model
    _.extend @prototype, Chaplin.EventBroker

    defaults:
      changed: null
      created: null
      uploaded: null

    initialize: (options) ->
      @on 'change:changed', @updateFormattedChanged, @
      @on 'change:created', @updateFormattedCreated, @
      @on 'change:uploaded', @updateFormattedUploaded, @

    updateFormattedChanged: (model, value, options) ->
      @set 'formatted_changed', "#{Moment(value).format('D. MMM YYYY, HH:mm:ss')} Uhr" if value? 

    updateFormattedCreated: (model, value, options) ->
      @set 'formatted_created', "#{Moment(value).format('D. MMM YYYY, HH:mm:ss')} Uhr" if value? 

    updateFormattedUploaded: (model, value, options) ->
      @set 'formatted_uploaded', "#{Moment(value).format('D. MMM YYYY, HH:mm:ss')} Uhr" if value? 