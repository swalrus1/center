--[[
    MIT License

    Copyright (c) 2019 Semyon Entsov <swalrus@yandex.ru>

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
]]--

local center = {}

function center:setupScreen(width, height)
    self._WIDTH = width
    self._HEIGHT = height
    self._MAX_WIDTH = 0
    self._MAX_HEIGHT = 0
    self._MAX_RELATIVE_WIDTH = 0
    self._MAX_RELATIVE_HEIGHT = 0
    self._SCREEN_WIDTH = love.graphics.getWidth()
    self._SCREEN_HEIGHT = love.graphics.getHeight()
    self._BORDERS = {
        ['t'] = 0,
        ['r'] = 0,
        ['b'] = 0,
        ['l'] = 0
    }
    self:apply()
    return self
end

function center:setBorders(top, right, bottom, left)
    self._BORDERS.t = top
    self._BORDERS.r = right
    self._BORDERS.b = bottom
    self._BORDERS.l = left
end

function center:setMaxWidth(width)
    self._MAX_WIDTH = width
end

function center:setMaxHeight(height)
    self._MAX_HEIGHT = height
end

function center:setMaxRelativeWidth(width)
    self._MAX_RELATIVE_WIDTH = width
end

function center:setMaxRelativeHeight(height)
    self._MAX_RELATIVE_HEIGHT = height
end

function center:resize(width, height)
    self._SCREEN_WIDTH = width
    self._SCREEN_HEIGHT = height
    self:apply()
end

function center:apply()
    local available_width = self._SCREEN_WIDTH - self._BORDERS.l - self._BORDERS.r
    local available_height = self._SCREEN_HEIGHT - self._BORDERS.t - self._BORDERS.b
    local max_width = available_width
    local max_height = available_height
    if self._MAX_RELATIVE_WIDTH > 0 and available_width * self._MAX_RELATIVE_WIDTH < max_width then
        max_width = available_width * self._MAX_RELATIVE_WIDTH
    end
    if self._MAX_RELATIVE_HEIGHT > 0 and available_height * self._MAX_RELATIVE_HEIGHT < max_height then
        max_height = available_height * self._MAX_RELATIVE_HEIGHT
    end
    if self._MAX_WIDTH > 0 and self._MAX_WIDTH < max_width then
        max_width = self._MAX_WIDTH
    end
    if self._MAX_HEIGHT > 0 and self._MAX_HEIGHT < max_height then
        max_height = self._MAX_HEIGHT
    end
    if max_height / max_width > self._HEIGHT / self._WIDTH then
        self._CANVAS_WIDTH = max_width
        self._CANVAS_HEIGHT = self._CANVAS_WIDTH * (self._HEIGHT / self._WIDTH)
    else
        self._CANVAS_HEIGHT = max_height
        self._CANVAS_WIDTH = self._CANVAS_HEIGHT * (self._WIDTH / self._HEIGHT)
    end
    self._SCALE = self._CANVAS_HEIGHT / self._HEIGHT
    self._OFFSET_X = self._BORDERS.l + (available_width - self._CANVAS_WIDTH) / 2
    self._OFFSET_Y = self._BORDERS.t + (available_height - self._CANVAS_HEIGHT) / 2
end

function center:start()
    love.graphics.push()
    love.graphics.translate(self._OFFSET_X, self._OFFSET_Y)
    love.graphics.scale(self._SCALE, self._SCALE)
end

function center:finish()
    love.graphics.pop()
end

function center:toGame(x, y)
    return (x - self._OFFSET_X) / self._SCALE,
           (y - self._OFFSET_Y) / self._SCALE
end

return center
