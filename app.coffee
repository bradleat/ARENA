require('zappajs') {
  port: require('./package.json').config.port
}, ->

  @configure
    development: =>
      @include "./config/development.coffee"
    production: =>
      @include "./config/production.coffee"
