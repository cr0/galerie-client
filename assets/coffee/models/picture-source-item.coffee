define (require) ->
  'use strict'

  Chaplin = require 'chaplin'

  Model   = require 'models/base/model'


  class PictureSourceItem extends Model
    _.extend @prototype, Chaplin.EventBroker

    defaults:
      name: null
      height: 0
      width: 0
