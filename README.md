# Framer Router

### Demos
 - [Simple](http://share.framerjs.com/atwfebiny4ls/)
 - [Enter and Exit Animations](http://share.framerjs.com/zquynaxhsdqg/)

## Quick Start
#### 1. Include in your Framer project
```coffeescript
{ Router, Route, Link } = require 'Router'
```
#### 2. Instantiate a new Router. Give it an indexRoute

```coffeescript
router = new Router
	indexRoute: 'Home'
#	debug = true
```

#### 3. Create a few routes and some child layers to go in them

```coffeescript
Home = new Route
	router: router
	name: 'Home'

Profile = new Route
	router: router # connect it to your router
	name: 'Profile' # give your route a name
	...

```
#### 4. Make links and all the nested layers you want.

```coffeescript
ProfilePic = new Layer
	parent: Home
	...
  
ProfilePic.onClick, () ->
	router.push('Profile')

# Or, you can use the Link API
Button = new Link
	router: router 
	to: 'Profile' 
	...
```

## Animations
By default, framer-router will just toggle visibilty. When you want to animate things, each `Route` has an optional `onEnter` and `onLeave` hook.

```coffeescript
Master = new Route
	router: router
	name: 'Master'
	y: 0
	scale: 1

# You can use a state machine, or just the `animate` API to manage intros and outros
Master.onEnter = () ->
	@animate
		properties:
			y: 0
			scale: 1
		curve: "spring(400,40,0)" 

Master.onLeave = () ->
	@animate
		properties:
			y: 500
			scale: .5
		curve: "spring(400,60,0)"
```

#### Notes:
  - Huge credit to Michael Feldstein for inspiration (http://codepen.io/msfeldstein/pen/klxbq).
