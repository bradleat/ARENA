Helpers = require('./Helpers.coffee').Helpers
exports.Controller = class Arena
	constructor: (cache) ->
		@helper = new Helpers()
		@qc = cache
	
	get_name: ->
		_name = 'get_arena_name'
		_type = 'string'
		_qc = @qc
		_helper = @helper
		_qc.cb.get 'start', (err, doc) ->
			if err
				_qc.res.send _helper.error _name, _type, err, 1
				throw err
			else if doc.arena_name
				_qc.res.send _helper.format _name, _type, doc.arena_name

	set_name: ->
		_name = 'set_arena_name'
		_type = 'status'
		_qc = @qc
		_helper = @helper
		_qc.cb.get 'start', (err, doc, meta) ->
			if err
				_qc.res.send _helper.error _name, _type, err, 1
				throw err
			else
				doc.arena_name = _qc.params.set
				_qc.cb.set 'start', doc, meta, (err) ->
					if err
						_qc.res.send _helper.error _name, _type, err, 2
						throw err
					else
						_qc.res.send _helper.format _name, _type, true
	
