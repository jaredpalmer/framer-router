#                                        $$\
#                                       $$ |
#        $$$$$$\   $$$$$$\  $$\   $$\ $$$$$$\    $$$$$$\   $$$$$$\
#       $$  __$$\ $$  __$$\ $$ |  $$ |\_$$  _|  $$  __$$\ $$  __$$\
#       $$ |  \__|$$ /  $$ |$$ |  $$ |  $$ |    $$$$$$$$ |$$ |  \__|
#       $$ |      $$ |  $$ |$$ |  $$ |  $$ |$$\ $$   ____|$$ |
#       $$ |      \$$$$$$  |\$$$$$$  |  \$$$$  |\$$$$$$$\ $$ |
#       \__|       \______/  \______/    \____/  \_______|\__|
#
#
# Copyright (c) 2016 Jared Palmer
# www.jaredpalmer.com
# @jaredpalmer


class Router extends Framer.BaseClass
	constructor: (props) ->
		props.debug ?= false
		super()
		@route = props.indexRoute
		@debug = props.debug
		@lastRoute = null
		@nextRoute = null

	push: (i) =>
		unless @route is i
			@lastRoute = @route
			@nextRoute = i
			if @debug
				print
					routeWillChange:
						lastRoute: @lastRoute
						nextRoute: @nextRoute

			@emit "routeWillChange"
			@route = i
			@emit "routeDidChange" # could be interesting if you want.
			if @debug then print routeDidChange: @route

# @TODO:
#	  goBack: () =>
#	    handle history array
#
#	  replace: () =>
#	    switch instantly to a route, perhaps no animations?


# Define the view classes to keep their code organized
class Route extends Layer
	constructor: (props) ->
		props.x ?= 0 # set default props
		props.y ?= 0 # set default props
		super(props)
		@router = props.router
		@visible = @router.route == @name
		@width = Framer.Screen.width
		@height = Framer.Screen.height
		@onLeave = props.onLeave
		@onEnter = props.onEnter
		@router.on "routeWillChange", @handleRouteChange
	
	handleOnLeave: () =>
		@emit "routeDidLeave"
		if @router.debug then print routeDidLeave: @name
	
	handleOnEnter: () => 
		@emit "routeDidEnter"
		if @router.debug then print routeDidEnter: @name
	
	handleRouteChange: () =>
		if @router.lastRoute is @name
			if @router.debug then print routeWillLeave: @name
			@emit "routeWillLeave"
			@ignoreEvents = true
			if @onLeave then @onLeave(@handleOnLeave) else visible = false

		if @router.nextRoute is @name
			if @router.debug then print routeWillEnter: @name
			@emit "routeWillEnter"
			@ignoreEvents = false
			@visible = true
			if @onEnter then @onEnter(@handleOnEnter)
			
# Link will tell the router to update.
# Should feel a little like a React Router's <Link/>.
class Link extends Layer
	constructor: (props) ->
		super props
		@router = props.router
		@to = props.to
		@on Events.Click, @clicked
	# When you click a Link, change routes
	clicked: () =>
		@router.push(@to)



exports.Route = Route
exports.Router = Router
exports.Link = Link
