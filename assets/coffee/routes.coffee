define ->
  'use strict'

  (match) ->
    match '', 'hello#show', name: 'hello_home'

    match 'login',                    'login#login',    name: 'login_login'
    match 'login/validate(/:token)',  'login#validate', name: 'login_validate'
    match 'logout',                   'login#logout',   name: 'login_logout'

    match 'imprint', 'static#imprint', name: 'static_imprint'

    match 'bucket/create', 'bucket#create', name: 'bucket_create'
    match 'bucket/:id', 'bucket#show', name: 'bucket_show'

    match 'a/picture', 'picture#create'

    match 'user/setting', 'user#setting', name: 'setting'

    #match '*notfound', 'hello#show'
