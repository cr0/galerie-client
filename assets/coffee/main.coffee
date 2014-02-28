require.config

  waitSeconds: 15
  baseUrl: '/js/'

  paths:
    'modernizr-b':       '../components/modernizr/modernizr-b'

  shim:
    'modernizr-b':
      exports: 'Modernizr'

  map:
    '*':
      'underscore': 'lodash'
      'modernizr': 'modernizr-b'

define 'gmaps', ['async!http://maps.google.com/maps/api/js?v=3&key=AIzaSyAPioLTf2snn7k023uPTMreFY-y1e0M10g&sensor=false'], () -> return window.google.maps


require ['application', 'routes'], (App, routes) ->
  new App
    routes: routes,
    controllerSuffix: '-controller'
    root: '/'
    apiRoot: 'http://localhost:3000/api/'
