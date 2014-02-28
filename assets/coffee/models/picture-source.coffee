define (require) ->
  'use strict'

  Chaplin           = require 'chaplin'

  Model             = require 'models/base/model'
  PictureSourceItem = require 'models/picture-source-item'


  class PictureSource extends Model
    _.extend @prototype, Chaplin.EventBroker

    relations: [
      type:           'HasOne'
      key:            'thumb'
      relatedModel:   PictureSourceItem
      includeInJSON:  yes
      reverseRelation:
        includeInJSON:no
    ,
      type:           'HasOne'
      key:            'low'
      relatedModel:   PictureSourceItem
      includeInJSON:  yes
      reverseRelation:
        includeInJSON:no
    ,
      type:           'HasOne'
      key:            'middle'
      relatedModel:   PictureSourceItem
      includeInJSON:  yes
      reverseRelation:
        includeInJSON:no
    ,
      type:           'HasOne'
      key:            'blur'
      relatedModel:   PictureSourceItem
      includeInJSON:  yes
      reverseRelation:
        includeInJSON:no
    ,
      type:           'HasOne'
      key:            'standard'
      relatedModel:   PictureSourceItem
      includeInJSON:  yes
      reverseRelation:
        includeInJSON:no
    ,
      type:           'HasOne'
      key:            'original'
      relatedModel:   PictureSourceItem
      includeInJSON:  yes
      reverseRelation:
        includeInJSON:no
    ]