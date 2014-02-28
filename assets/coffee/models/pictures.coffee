define (require) ->
  'use strict'

  Chaplin       = require 'chaplin'

  Collection   = require 'models/base/collection'
  Picture      = require 'models/picture'

  class Pictures extends Collection
    _.extend @prototype, Chaplin.EventBroker

    url:    'picture'
    model:  Picture
