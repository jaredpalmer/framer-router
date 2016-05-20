# Framer Router

### Demos
 - [Simple](http://share.framerjs.com/atwfebiny4ls/)
 - [Enter and Exit Animations](http://share.framerjs.com/zquynaxhsdqg/)


### 1. Include in your Framer project
```coffeescript
{ Router, Route } = require 'Router'
```
### 2. Instantiate a new Router. Give it an indexRoute

```coffeescript
router = new Router
  indexRoute: 'Home'
# debug = true
```

### 3. Create some routes and some child layers to go in them

```coffeescript

Home = new Route
  router: router
  name: 'Home'

HomeProfilePic = new Layer
  parent: Home
  ...

Profile = new Route
  router: router # connect it to your router
  name: 'Profile' # give your route a name
  ...

```
### 4. Make a link

```coffeescript
HomeProfilePic.onClick, () ->
  router.push('Profile')
```

#### Notes:
  - Huge credit to Michael Feldstein for inspiration (http://codepen.io/msfeldstein/pen/klxbq).
