Helper = require('./Helpers.coffee').Helpers
exports.Controller = class Games
  constructor: (cache, doc) ->
    @helper = new Helper()
    @qc = cache
    if doc
      @inner = doc
    else
      @inner =
        type: 'GAME'
        name: ""
        competitors: []
        leagues: []
        rules:
          min_players: 0
          max_players: 1
          min_teams: 1
          max_teams: 1

  is_competitor: ->
    _name = 'game:is_competitor'
    _type = 'boolean'
    _qc = @qc
    _helper = @helper
    _qc.cb.get "GAME_#{_qc.params.game}", (err, doc) ->
      if err
        _qc.res.send _helper.error _name, _type, err, 1
        throw err
      else if _qc.params.is in doc.competitors
        _qc.res.send _helper.format _name, _type, true
      else
        _qc.res.send _helper.format _name, _type, false

  add_competitor: ->
    _name = 'game:add_competitor'
    _type = 'status'
    _qc = @qc
    _helper = @helper
    _qc.cb.get "GAME_#{_qc.params.game}", (err, doc, meta) ->
      if err
        _qc.res.send _helper.error _name, _type, err, 1
        throw err
      else if _qc.params.add not in doc.competitors
        doc.competitors.push _qc.params.add
        _qc.cb.set "GAME_#{_qc.params.game}", doc, meta, (err) ->
          if err
            _qc.res.send _helper.error _name, _type, err, 2
            throw err
          else
            _qc.res.send _helper.format _name, _type, true
      else
        _qc.res.send _helper.error _name, _type, 'Already a Competitor', 3
  
  #report_results
  #remove_competitor
  #add_league
  #remove_league
  #set/get_min_players
  #set/get_max_players
  #set/get_min_teams
  #set/get_max_teams


