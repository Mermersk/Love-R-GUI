local class = require("middleclass")

local toolbar = class("toolbar")

require("stack")
toolbar.static.elements = {}

function toolbar:initialize(width, height, slots) --Slots are how many slots/rectangles the UI should have

  self.width = width
  self.height = height
  self.number_of_slots = slots

  self.single_slot_width = self.width
  self.single_slot_height = self.height / self.number_of_slots

  self.original_window_width, self.original_window_height = love.graphics.getDimensions() --original_window_width is only called once in load, therefore captures the resolution at startup

  self.stacks = {stack:create(), stack:create()}

  local y_placement = 0
  for i = 1, self.number_of_slots do
    self.stacks[1]:push({label = "box" .. i, x = self.original_window_width - self.single_slot_width, y = y_placement, width = self.single_slot_width, height = self.single_slot_height, canvas = love.graphics.newCanvas(single_slot_width, single_slot_height), offscreen = false})
    local obj = self.stacks[1]:peek() --Gets the latest stack item that was inserted
    y_placement = obj.y + obj.height --Each succesive box y gets increased by the last box height

    love.graphics.setCanvas(obj.canvas)
      love.graphics.setColor(0.3, 0.6, 0.4, 1)
      love.graphics.rectangle("line", 0, 0, obj.width, obj.height)
      love.graphics.print(obj.label, 25, 1)
      love.graphics.print(obj.width .. "x" .. obj.height, 25, 25)
      love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setCanvas()

  end

  draw_table = {}

end

function toolbar:update(dt)

  index_before_frontier = #self.stacks - 1
  index_frontier = #self.stacks --This is the index for the stack that is currently most displaced

  self.window_width, self.window_height = love.graphics.getDimensions()
  for i = 1, #self.stacks do
    draw_table[i] = self.stacks[i]:toTable()
  end

  for i = 1, #self.stacks do
    for key, value in pairs(draw_table[i]) do
      if i == 1 then
        value.x = self.window_width - value.width --X-position responding to resizing
      else
        value.x = self.window_width - (value.width*i) --If i is more than one then it means it is in stack 2 or more and therefore wee need to multiply the width to correspond with that
      end
    end
  end

  local obj = self.stacks[1]:peek()

  if obj.y + obj.height > self.window_height then
    obj.offscreen = true
  end

  if obj.offscreen == true then
    local pop index = 1
    if #self.stacks > 1 then --If there are more than 1 stacks in stacks table
      pop_index = #self.stacks - 1
    end

    local obj_popped = self.stacks[1]:pop()
    obj_popped.x = obj_popped.x - obj_popped.width
    if self.stacks[2]:size() == 0 then
      obj_popped.y = 0
    else
      obj_popped.y = self.stacks[2]:peek().y + self.single_slot_height
    end
    obj_popped.offscreen = false
    self.stacks[2]:push(obj_popped)
  end

  if self.stacks[2]:peek() ~= nil then --We only want to return an element if it has already been displaced
    if isRoom(self.stacks[1]:peek(), self.window_height) == true then
      local obj_popped = self.stacks[2]:pop()
      obj_popped.x = obj.x
      obj_popped.y = obj.y + self.single_slot_height
      self.stacks[1]:push(obj_popped)
    end
  end
end

function isRoom(obj, window_height)
  box_detect = obj.y + (obj.height * 2)
  if box_detect < window_height then --*2 to check one place beneath current last object in stack
    return true
  else
    return false
  end

end

function toolbar:draw()
  for i = 1, #self.stacks do
    for key, value in pairs(draw_table[i]) do
      love.graphics.draw(value.canvas, value.x, value.y)
    end
  end

  local obj = self.stacks[1]:peek()
  love.graphics.print(obj.label, 0, 0)
  love.graphics.print("Stack 1 size: " .. self.stacks[1]:size(), 0, 25)
  if self.stacks[2] ~= nil then
    love.graphics.print("Stack 2 size: " .. self.stacks[2]:size(), 0, 50)
  end
  love.graphics.print("Size of self.stacks: " .. #self.stacks, 0, 75)
  love.graphics.print("size of draw_table: " .. #draw_table, 0, 100)
  love.graphics.print(#self.stacks[1]:toTable(), 0, 125)
end

function toolbar:split()


end

function toolbar:add(element)
  table.insert(toolbar.static.elements, element)
end

return toolbar
