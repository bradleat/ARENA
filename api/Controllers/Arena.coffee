#Add/Remove Game/Operator must also Add/Remove both the index in start and the
#Game/Operator Document
Helpers = require('./Helpers.coffee').Helpers
exports.Controller = class Arena
	constructor: (cache, doc) ->
		@helper = new Helpers()
		@qc = cache
		if doc
			@inner = doc
		else
			@inner =
				type: 'APP_BASE'
				name: ""
				operators: []
				games: []
	
	is_operator: ->
		_name = 'arena:is_operator'
		_type = 'boolean'
		_qc = @qc
		_helper = @helper
		_qc.cb.get 'start', (err, doc) ->
			if err
				_qc.res.send _helper.error _name, _type, err, 1
				throw err
			else if doc.operators
				if _qc.params.operator in doc.operators
					_qc.res.send _helper.format _name, _type, true
				else
					_qc.res.send _helper.format _name, _type, false
			else _qc.res.send _helper.format _name, _type, false
				
	get_operators: ->
		_name = 'arena:get_operators'
		_type = 'array strings'
		_qc = @qc
		_helper = @helper
		_qc.cb.get 'start', (err, doc) ->
			if err
				_qc.res.send _helper.error _name, _type, err, 1
				throw err
			else
				_qc.res.send _helper.format _name, _type, doc.operators
	
	add_operator: ->
		_name = 'arena:add_operator'
		_type = 'status'
		_qc = @qc
		_helper = @helper
		_qc.cb.get 'start', (err, doc, meta) ->
			if err
				_qc.res.send _helper.error _name, _type, err, 1
				throw err
			else if _qc.params.add not in doc.operators
				doc.operators.push _qc.params.add
				_qc.cb.set 'start', doc, meta, (err) ->
					if err
						_qc.res.send _helper.error _name, _type, err, 2
						throw err
					else
						_qc.res.send _helper.format _name, _type, true
			else
				_qc.res.send _helper.error _name, _type, 'Already an Operator', 3
	
	remove_operator: ->
		_name = 'arena:remove_operator'
		_type = 'status'
		_qc = @qc
		_helper = @helper
		Array::_remove = @helper.Array_remove
		_qc.cb.get 'start', (err, doc, meta) ->
			if err
				_qc.res.send _helper.error _name, _type, err, 1
				throw err
			else if _qc.params.remove in doc.operators
				doc.operators._remove _qc.params.remove
				_qc.cb.set 'start', doc, meta, (err) ->
					if err
						_qc.res.send _helper.error _name, _type, err, 2
						throw err
					else
						_qc.res.send _helper.format _name, _type, true
			else
				_qc.res.send _helper.error _name, _type, 'Not an Operator', 3
	#get_games
	#add_game
	#remove_game
	#is_game

	get_name: ->
		_name = 'arena:get_name'
		_type = 'string'
		_qc = @qc
		_helper = @helper
		_qc.cb.get 'start', (err, doc) ->
			if err
				_qc.res.send _helper.error _name, _type, err, 1
				throw err
			else
				_qc.res.send _helper.format _name, _type, doc.name

	set_name: ->
		_name = 'arena:set_name'
		_type = 'status'
		_qc = @qc
		_helper = @helper
		_qc.cb.get 'start', (err, doc, meta) ->
			if err
				_qc.res.send _helper.error _name, _type, err, 1
				throw err
			else
				doc.name = _qc.params.set
				_qc.cb.set 'start', doc, meta, (err) ->
					if err
						_qc.res.send _helper.error _name, _type, err, 2
						throw err
					else
						_qc.res.send _helper.format _name, _type, true
	
	add_game: ->
		_name = 'arena:add_game'
		_type = 'status'
		_qc = @qc
		_helper = @helper
		_qc.cb.get "GAME_#{_qc.params.name}", (err, doc, meta) ->
			if !err
				_qc.res.send _helper.error _name, _type, 'Game might Already Exist', 1
			else if doc
				_qc.res.send _helper.error, _name, _type, 'Game Already Exists', 2
			else
				Game = require('./Games.coffee').Game
				_game = new Game().inner
				_game.name = _qc.params.name

				_qc.cb.set "GAME_#{_qc.params.name}", _game, meta, (err) ->
					if err
						_qc.res.send _helper.error _name, _type, err, 3
					else
						_qc.res.send _helper.format _name, _type, true
	
	is_game: ->
    _name = 'arena:is_game'
    _type = 'boolean'
    _qc = @qc
    _helper = @helper
    _qc.cb.get 'start', (err, doc) ->
      if err
        _qc.res.send _helper.error _name, _type, err, 1
        throw err
      else if doc.games
        if _qc.params.game in doc.games
          _qc.res.send _helper.format _name, _type, true
        else
          _qc.res.send _helper.format _name, _type, false
      else _qc.res.send _helper.format _name, _type, false
        
  get_games: ->
    _name = 'arena:get_games'
    _type = 'array strings'
    _qc = @qc
    _helper = @helper
    _qc.cb.get 'start', (err, doc) ->
      if err
        _qc.res.send _helper.error _name, _type, err, 1
        throw err
      else
        _qc.res.send _helper.format _name, _type, doc.games
  
	remove_game: ->
    _name = 'arena:remove_game'
    _type = 'status'
    _qc = @qc
    _helper = @helper
    Array::_remove = @helper.Array_remove
    _qc.cb.get 'start', (err, doc, meta) ->
      if err
        _qc.res.send _helper.error _name, _type, err, 1
        throw err
      else if _qc.params.remove in doc.games
        doc.games._remove _qc.params.remove
        _qc.cb.set 'start', doc, meta, (err) ->
          if err
            _qc.res.send _helper.error _name, _type, err, 2
            throw err
          else
            _qc.res.send _helper.format _name, _type, true
      else
        _qc.res.send _helper.error _name, _type, 'Not a Operator', 3
