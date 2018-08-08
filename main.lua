local toolbar = require("toolbar")
local element = require("element")
function love.load()

  toolbar = toolbar:new(200, 800, 18)
  --octaves = element:new("Octaves", 100, 50)
  --toolbar:add(octaves)
end


function love.update(dt)

  toolbar:update(dt)

end


function love.draw()

  toolbar:draw()

end
