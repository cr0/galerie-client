define (require) ->
  'use strict'

  Chaplin         = require 'chaplin'
  Moment          = require 'moment'

  Model           = require 'models/base/model'
  Picture         = require 'models/picture'
  Pictures        = require 'models/pictures'
  Location        = require 'models/location'
  Tag             = require 'models/tag'
  Tags            = require 'models/tags'
  User            = require 'models/user'


  class Bucket extends Model
    _.extend @prototype, Chaplin.EventBroker

    urlRoot: 'bucket'

    defaults:
      name:       'Bucket'
      author:     '<UNKNOWN_AUTHOR>'
      date:       '<UNKNOWN_DATE>'

    relations: [
      type:           'HasOne'
      key:            'from'
      relatedModel:   User
      includeInJSON:  ['_id', 'name']
      reverseRelation:
        includeInJSON:no
    ,
      type:           'HasMany'
      key:            'pictures'
      relatedModel:   Picture
      collectionType: Pictures
      includeInJSON:  ['_id', 'name']
      reverseRelation:
        includeInJSON:  no
    ,
      type:           'HasMany'
      key:            'tags'
      relatedModel:   Tag
      collectionType: Tags
      includeInJSON:  ['_id', 'deletable']
      reverseRelation:
        includeInJSON:no
    ,
      type:           'HasOne'
      key:            'location'
      relatedModel:   Location
      includeInJSON:  yes
      reverseRelation:
        includeInJSON:no
    ]

    initialize: ->
      @set 'preview', "http://lorempixel.com/400/400/?#{Math.random()}"
      @on 'change:date', @updateFormattedDate, @


    updateFormattedDate: (model, value, options) ->
      # Thu Jan 02 13:10:56 CET 2014
      @set 'formatted_date', "#{Moment.unix(value/1000).format('D. MMM YYYY')}" if value?


    comparator: (model) -> model.get('name')
