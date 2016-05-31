# Framer Router

### Demos
 - [Enter and Exit Animations](http://share.framerjs.com/u2rvcvm0h2dq/)

## Quick Start
#### 1. Include in your Framer project
```coffeescript
{ Router, Route, Link } = require 'Router'
```
#### 2. Instantiate a new Router. Give it an indexRoute

```coffeescript
router = new Router
	indexRoute: 'RouteOne'
```

#### 3. Create a few routes and some child layers to go in them

```coffeescript
RouteOne = new Route
	router: router
	name: 'RouteOne'

RouteTwo = new Route
	router: router # connect it to your router
	name: 'RouteTwo' # give your route a name
	x: 755

```
#### 4. Make a link

```coffeescript
RouteOne.onClick () ->
	router.push('RouteTwo')

# Or, you can use the Link API
Button = new Link
	router: router 
	to: 'RouteTwo' 
	parent: RouteOne
```

#### 5. Add Animations
By default, framer-router will just toggle visibilty. When you want to animate things, each `Route` has an optional `onEnter` and `onLeave` hook. Both `onEnter` and `onLeave` can call a callback function that simply emits `routeDidLeave` and `routeDidEnter` respectively.

```coffeescript
# You can use a state machine, or just the `animate` API to manage intros and outros

RouteOne.onEnter = () ->
	@animate
		properties:
			y: 0
			scale: 1
		curve: "spring(400,40,0)" 

RouteOne.onLeave = () ->
	@animate
		properties:
			y: 500
			scale: .5
		curve: "spring(400,60,0)"
...

RouteTwo.onEnter = (done) ->
	@animate
		properties:
			x: 0
		curve: "spring(400,40,0)"
	done() # emits 'routeDidEnter' event

RouteTwo.onLeave = (done) ->
	@animate
		properties:
			x: 755
		curve: "spring(400,60,0)"
	done() # emits 'routeDidLeave' event
```

#### Notes:
  - Huge credit to Michael Feldstein for inspiration (http://codepen.io/msfeldstein/pen/klxbq).
