define (require) ->
  'use strict'

  Chaplin       = require 'chaplin'

  Collection    = require 'models/base/collection'
  Tag           = require 'models/tag'


  class Tags extends Collection
    _.extend @prototype, Chaplin.EventBroker

    url:    'tag'
    model:  Tag
