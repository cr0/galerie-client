path = require 'path'
modRewrite  = require 'connect-modrewrite'
mountFolder = (connect, dir) ->
  connect.static require("path").resolve(dir)

module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt);

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    clean:
      coverage:
        src:        ['src/**/*.js']
      public:
        src:        ['public/css/**', 'public/js/**', 'public/fonts/**']

    copy:
      fonts:
        expand:   true
        cwd:      'public/components/font-awesome/fonts/'
        src:      '*'
        dest:     'public/fonts'
        filter:   'isFile'


    coffee:
      client:
        options:
          sourceMap: true
#          sourceRoot: 'coffee/'
        files: [
          expand:   true
          cwd:      'assets/coffee'
          src:      ['**/*.coffee']
          dest:     'public/js/'
          ext:      '.js'
        ]

    mochacov:
      coverage:
        options:
          require:        ['.codecov.js']
          coveralls:
            serviceName:  'travis-ci'
      options:
        recursive:    true
        files:        'test/**/*-test.coffee'
        compilers:    ['coffee:coffee-script']

    stylus:
      assets:
        options:
          use: [
            require('nib')
          ]
          paths: [
            'public/'
          ]
          urlfunc:    'url',
          linenos:    true,
          'include css': true
        files:
          'public/css/main.css':      'assets/styl/main.styl'
          'public/css/finalize.css':  'assets/styl/pages/finalize.styl'
          'public/css/error.css':     'assets/styl/pages/error.styl'

    jade:
      static:
        options:
          pretty: yes
        files:
          'public/index.html':  'views/index.jade'

      client:
        options:
          amd: true
          namespace: false
          client: true
          compileDebug: false
          processName: ( filename ) ->
            path.basename( filename ).split( '.' )[0]
        files:
          'public/js/templates/bucket-index.js':   'assets/tpl/bucket/index.jade'
          'public/js/templates/bucket-new.js':    'assets/tpl/bucket/new.jade'

          'public/js/templates/picture-item.js':       'assets/tpl/picture/item.jade'
          'public/js/templates/picture-items.js':       'assets/tpl/picture/items.jade'
          'public/js/templates/picture-new.js':         'assets/tpl/picture/new.jade'
          'public/js/templates/picture-upload.js':      'assets/tpl/picture/upload.jade'
          'public/js/templates/picture-add.js':     'assets/tpl/picture/add.jade'
          'public/js/templates/picture-tool.js':        'assets/tpl/picture/tool.jade'

          'public/js/templates/setting.js':       'assets/tpl/setting.jade'

          'public/js/templates/footer.js':        'assets/tpl/footer.jade'
          'public/js/templates/imprint.js':       'assets/tpl/imprint.jade'
          'public/js/templates/login.js':         'assets/tpl/login.jade'
          'public/js/templates/error.js':         'assets/tpl/error.jade'
          'public/js/templates/skeleton.js':      'assets/tpl/skeleton.jade'

          'public/js/templates/ajax/.js':         'assets/tpl/ajax/login.jade'

          'public/js/templates/home/index.js':        'assets/tpl/home/index.jade'
          'public/js/templates/home/search.js':       'assets/tpl/home/search.jade'
          'public/js/templates/home/search-stats.js': 'assets/tpl/home/search-stats.jade'
          'public/js/templates/home/result.js':       'assets/tpl/home/result.jade'

    modernizr:
      client:
        devFile:    'public/components/modernizr/modernizr.js'
        outputFile: 'public/components/modernizr/modernizr-b.js'
        parseFiles: yes
        uglify:     no
        files:
          src: ['public/js/**/*.js', 'public/css/**']

    requirejs:
      compile:
        options:
          preserveLicenseComments: false
          generateSourceMaps: false
          baseUrl: 'public/js'
          name: 'main'
          mainConfigFile: 'public/js/main.js'
          out: 'public/js/optimized.js'

    shell:
      coverage:
        command:    './node_modules/coffee-coverage/bin/coffeecoverage --initfile .codecov.js --exclude node_modules,Gruntfile.coffee,.git,test,assets --path relative . .'

    bower:
      client:
        rjsConfig:  'public/js/main.js'

    watch:
      coffee:
        files:      ['src/**/*.coffee']
        tasks:      ['clean:server', 'newer:coffee:server']
      client:
        files:      ['assets/styl/**/*.styl', 'assets/tpl/**/*.jade', 'assets/coffee/**/*.coffee']
        tasks:      ['stylus:assets', 'newer:jade:client', 'newer:coffee:client', 'bower:client']
        options:
          livereload: true

    connect:
      server:
        options:
          port: 3001
          base: 'public'
          keepalive: no
          debug: no
          middleware: (connect) ->
            return [
              modRewrite [
                '^/assets/(.*) /$1?asset [R]'
                '!\\.html|\\.js|\\.css|\\.png|\\.svg|\\.ttf|\\.woff|\\.map$ /index.html [L]'
              ]
              mountFolder connect, 'bower_components'
              mountFolder connect, 'assets'
              mountFolder connect, 'public'
            ]


  grunt.registerTask 'build', [
    'clean:public', 'coffee:client', 'stylus:assets', 'jade:client'
  ]

  grunt.registerTask 'test', [
    'mochacov:server'
  ]

  grunt.registerTask 'travis', [
     'shell:coverage', 'mochacov:coverage', 'clean:coverage'
  ]

  grunt.registerTask 'dev', [
    'clean:public', 'newer:copy:fonts', 'stylus:assets', 'newer:jade:static', 'newer:jade:client',
    'newer:coffee:client', 'modernizr:client', 'bower:client', 'connect:server', 'watch'
  ]
