@include = ->
  @helper route: (_class, method) ->
    Controller = require("./Controllers/#{_class}.coffee").Controller
    new Controller(@qc())[method]()

  @helper qc: -> #quick cache
    cache =
      params: @params
      res: @res
      cb: @app.cb


  # API BASE
  @get '/': ->
    @res.send
      about: "ARENA API BASE v#{require('../package').version}"
      api: "BASE"
  ####TODO:
  ####Make the pattern of calling @get/verb/class/method
  ####                              @route/class/verb_method
  ####systatmatic so we can be lazy and infer a route
  ## Arena
  # Get the Name of the Current Arena PERM: Operator
  @get '/get/arena/name': ->
    @route 'Arena', 'get_name'

  # Set the Name of the Current Arena PERM: Operator
  @get '/set/arena/name/:set': ->
    @route 'Arena', 'set_name'
  @get '/set/arena/name': ->
    @params.set = @query.set
    @route 'Arena', 'set_name'

  # Create a Arena Game PERM: Operator
  @get '/add/arena/game/:add': ->
    @route 'Arena', 'add_game'
  
  @get '/add/arena/game': ->
    @params.add = @query.add
    @route 'Arena', 'add_game'

  # Check to see if a game exists PERM: None
  @get '/is/arena/game/:is': ->
    @route 'Arena', 'is_game'
  @get '/is/arena/game' : ->
    @params.is = @query.is
    @route 'Arena', 'is_game'

  # Get List of Games PERM: None
  @get '/get/arena/games/': ->
    @route 'Arena', 'get_games'

  # Remove a Game from the Arena PERM: Operator
  @get '/remove/arena/game/:remove': ->
    @route 'Arena', 'remove_game'
  @get '/remove/arena/game' : ->
    @params.remove = @query.remove
    @route 'Arena', 'remove_game'

  # Check to see if someone is an Operator PERM: None
  @get '/is/arena/operator/:is': ->
    @route 'Arena', 'is_operator'
  @get '/is/arena/operator' : ->
    @params.is = @query.is
    @route 'Arena', 'is_operator'


  # Get List of Arena Operators PERM: None
  @get '/get/arena/operators': ->
    @route 'Arena', 'get_operators'

  # Add an Operator to the Arena PERM: OPERATOR or ADMIN
  @get '/add/arena/operator/:add': ->
     @route 'Arena', 'add_operator'
  @get '/add/arena/operator' : ->
    @params.add = @query.add
    @route 'Arena', 'add_operator'

  # Remove an Operator from the Arena PERM: OPERATOR OR ADMIN
  @get '/remove/arena/operator/:remove': ->
    @route 'Arena', 'remove_operator'
  @get '/remove/arena/operator' : ->
    @params.remove = @query.remove
    @route 'Arena', 'remove_operator'


  # Add a Competitor to a Game PERM: OPERATOR, OWNER, OR ADMIN
  @get '/add/game/competitor': ->
    @params.add = @query.add
    @params.game = @query.game
    @route 'Games', 'add_competitor'

  # Check to see if someone is a Game Competitor PERM: NONE
  @get '/is/game/competitor': ->
    @params.is = @query.is
    @params.game = @query.game
    @route 'Games', 'is_competitor'

