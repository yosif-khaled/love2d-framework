player = {}

windowWidth = love.graphics.getWidth()
windowHeight = love.graphics.getHeight()

function player:load()
  self.x = 50
  self.y = windowHeight/2
  self.width = 20
  self.height = 100
  self.speed = 500
end

function player:update(dt)
  self:move(dt)
  self:checkBoundaries()
end

function player:move(dt)
    if love.keyboard.isDown('w') or love.keyboard.isDown('up') then
    self.y = self.y - self.speed*dt
  elseif love.keyboard.isDown('s') or love.keyboard.isDown('down') then
    self.y = self.y + self.speed*dt
  end
end

function player:checkBoundaries()
  if self.y < 0 then
    self.y = 0
  elseif self.y >= windowHeight - self.height then
    self.y = windowHeight - self.height
  end
end

function player:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end