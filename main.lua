local toolbar = require("toolbar")
local element = require("element")
function love.load()

  toolbar = toolbar:new(200, 70, 14) --parameter 1 = slot width, 2 = slot height, 3 = how many slots
  --octaves = element:new("Octaves", 100, 50)
  --toolbar:add(octaves)
end


function love.update(dt)

  toolbar:update(dt)

end


function love.draw()

  toolbar:draw()

end
