define [
  'lib/utils'
  'chaplin'
  'controllers/base/auth-controller'
  'views/user/setting-view'
], (utils, Chaplin, AuthController, SettingView) ->
  'use strict'

  class UserController extends AuthController

    setting: (params) ->
      @adjustTitle 'Settings'

      @search = new SettingView
        model:  Chaplin.mediator.user
        region: 'setting'

      utils.pageTransition $('#setting'), 'top'