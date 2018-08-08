require("simple-slider")
local class = require("middleclass")

local element = class("element")

--This is a class for one element in the toolbar. For example a slider.

function element:initialize(label, x, y)

  self.x = x
  self.y = y
  --self.canvas = love.graphics.newCanvas(self.x, self.y)

  self.label = label
  self.label_x = self.x - 55
  self.label_y = self.y - 25

  self.current_value_x = self.label_x + 75
  self.current_value_y = self.label_y

  self.initial_value = 50
  self.min_value = 1
  self.max_value = 100
  self.slider_length = 150

  self.slider = newSlider(self.x, self.y, self.slider_length, self.initial_value, self.min_value, self.max_value)
  self.current_value = 0
end

function element:update(dt)

  self.slider:update()
  self.current_value = self.slider:getValue()

end

function element:draw()

  self.slider:draw()
  love.graphics.print(self.label, self.label_x, self.label_y)
  love.graphics.print(self.current_value, self.current_value_x, self.current_value_y)

end

return element
