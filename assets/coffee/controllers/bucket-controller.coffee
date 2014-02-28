define (require) ->
  'use strict'

  $                   = require 'jquery'
  utils               = require 'lib/utils'
  
  AuthController      = require 'controllers/base/auth-controller'

  Bucket              = require 'models/bucket'

  BucketView          = require 'views/bucket/index-view'
  BucketCreateView    = require 'views/bucket/create-view'

  class BucketController extends AuthController

    show: (params) ->
      @adjustTitle 'bucket'

      bucket = Bucket.findOrCreate _id: params.id
      view   = new BucketView model: bucket, region: 'gallery'

      utils.pageTransition $('#gallery'), 'right'


    create: (params) ->
      @adjustTitle 'Erstelle Bucket...'

      # create a temporary bucket
      bucket = new Bucket
        name:         "Temp-#{utils.uuid4()}"
        temporary:    yes

      view = new BucketCreateView
        region:      'dynamic'
        model:       bucket

      @listenTo bucket, 'sync', => @publishEvent '!router:route', "/bucket/#{bucket.id}"
      @listenTo bucket, 'error', => @publishEvent '!error', new Error 'Unable to create temporary bucket for uploading pictures'

      utils.pageTransition $('#dynamic'), 'top'

