# center
Center is a simple library that dynamically aligns content to the center of game window.

<img src="https://github.com/S-Walrus/center/blob/master/screenshots/center.png?raw=true" width="256">

## Setup

```lua
local center = require "center"

center:setupScreen(600, 400)

function love.draw()
  center:start()
  
  -- draw here
  
  center:finish()
end

function love.resize(width, height)
  center:resize(width, height)
end
```

## API

### setupScreen
```lua
center:setupScreen(width, height)
```
Initializes Center

### apply
```lua
center:apply()
```
Applies changes.

This function is responsible for the whole alignment process, so any function (except for `setupScreen` and `resize`) will not make sense without `apply()` after it.

### setMaxWidth
```lua
center:setMaxWidth(width)
```
Width of the content **won't be greater** than specified value (default value is 0, that means that there is no boundaries).

### setMaxHeight
```lua
center:setMaxHeight(height)
```
Works the same as the previous one.

### setMaxRelativeWidth
```lua
center:setMaxRelativeWidth(width)
```
The **relative** width of the content (actual width / available width) **won't be greater** than specified value (default value is 0, that means that there is no relative boundaries).

### setMaxRelativeHeight
```lua
center:setMaxRelativeHeight(height)
```
Works the same as the previous one.

### setBorders
```lua
center:setBorders(t, r, b, l)
```
Specify the available area for the content.
Each argument represents how far the content should be placed from each side from top to left clockwise.
The content is aligned to the center of **this** area.

*For better understanding, illustrations will be added soon*

### start, finish

```lua
function love.draw()
  center:start()
  
  -- draw here
  
  center:finish()
end
```
This pair of functions is supposed to be called once inside `love.draw()`. Any rendering after `center.finish()` affect the default canvas, so you can draw UI or anything else.

### toGame

```lua
center:toGame(x, y)
```
Return position of a point in aligned coordinate system insead of default one.
