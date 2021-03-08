local x = 100
local direction = 1

function love.load()
  
end

function love.update(dt)
  if dt < 0.010 then return end
  if x < 120 then
    direction = 1
  elseif x > 400 then
    direction  = - 1
  end
  x = x + 200 * direction * dt
end

function love.draw()
  love.graphics.setColor(128/255, 54/255, 1)
  love.graphics.rectangle('fill', x, 100, 100, 50)
end