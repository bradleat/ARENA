@include = ->
	@helper route: (_class, method) ->
		Controller = require("./Controllers/#{_class}.coffee").Controller
		new Controller(@qc())[method]()
	
	@helper qc: -> #quick cache
		cache =
			params: @params
			res: @res
			base: @base
			format: @format
			error: @error
			cb: @app.cb
	
	
	# API BASE
	@get '/': ->
		@res.send
			about: "ARENA API BASE v#{require('../package').version}"
			api: "BASE"
	
	# Get the Name of the Current Arena
	@get '/get/arena/name': ->				@route 'Arena', 'get_name'
	
	# Set the Name of the Current Arena
	@get '/set/arena/name/:set': ->		@route 'Arena', 'set_name'
