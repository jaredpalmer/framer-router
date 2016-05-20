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
#
# 1. Import the module
#
# { Router, Route } = require 'Router'
#
#
# 2. Make a new Router instance
#
# router = new Router
# 	indexRoute: 'A'
#
#
# 3. Create some routes
#
# B = new Route
# 	router: router # connect it to your router
# 	name: 'B' # give your route a name (a.k.a. path)
# 	backgroundColor: '#fff'
# 	color: 'black'
# 	html: 'Route B'
# 	style:
# 		fontSize: '100px'
# 		lineHeight: '1335px'
# 		textAlign: 'center'
#
# A = new Route
# 	router: router
# 	name: 'A'
# 	backgroundColor: "#303138"
# 	html: 'Route A'
# 	style:
# 		fontSize: '100px'
# 		lineHeight: '1335px'
# 		textAlign: 'center'
#
#
# 4. Make a 'link'
#
# A.onClick () ->
# 	router.push('B')
#

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

			@emit "change:routeWillChange"
			@route = i
			@emit "change:routeDidChange" # could be interesting if you want.
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
		@router.on "change:routeWillChange", @handleRouteChange

	handleRouteChange: () =>
		if @router.lastRoute is @name
			if @router.debug then print @name + '.onLeave()'
			@emit "change:onLeave"
			if @onLeave then @onLeave()
			@visible = false

		if @router.nextRoute is @name
			if @router.debug then print @name + '.onEnter()'
			@emit "change:onEnter"
			@visible = true
			if @onEnter then @onEnter()

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
