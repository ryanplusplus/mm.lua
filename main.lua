local Animation = require 'src.Animation'
local run
local stand

function love.load()
  run = Animation('res/mm/run.png', 4, 7)
  stand = Animation('res/mm/stand.png', 10, 10)
end

function love.draw()
  love.graphics.print("Hello World!", 400, 300)
  love.graphics.print("Current FPS: " .. tostring(love.timer.getFPS()), 10, 10)
  run.draw(200, 200)
  stand.draw(150, 200)
end

function love.update(dt)
  run.step()
  stand.step()
end
