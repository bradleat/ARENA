_cb = require('./node_modules/couchbase/lib/couchbase.js')
_cb.connect { }, (err, cb) ->
	if err
		throw err
	require('zappajs') {
		port: require('./package.json').config.port
	}, ->
		@app.cb = cb
		
		@configure
			development: =>
				@include "./config/development.coffee"
			production: =>
				@include "./config/production.coffee"
		@include './api/routes.coffee'
		
		cb.get 'start', (err, doc, meta) ->
			if err
				if (!doc)
					doc =
						count: 0
				else
					throw err

			doc.count++

			cb.set 'start', doc, meta, (err) ->
				if err
					throw err

