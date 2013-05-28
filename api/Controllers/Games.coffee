exports.Game = class Games
  constructor: (cahce, doc) ->
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

  #is_competitor
  #add_competitor
  #remove_competitor
  #add_league
  #remove_league
  #set/get_min_players
  #set/get_max_players
  #set/get_min_teams
  #set/get_max_teams


