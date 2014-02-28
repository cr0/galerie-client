define (require) ->
  'use strict'

  $                   = require 'jquery'
  moment              = require 'moment'
  utils               = require 'lib/utils'

  AuthController      = require 'controllers/base/auth-controller'


  class PictureController extends AuthController

    create: (params) ->
      @adjustTitle 'a/Picture'
      @redirectToRoute 'bucket_create' 

