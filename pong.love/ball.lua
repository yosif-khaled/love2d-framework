ball = {}

windowWidth = love.graphics.getWidth()
windowHeight = love.graphics.getHeight()

function ball:load()
  self.x = windowWidth/2
  self.y = windowHeight/2
  self.width = 20
  self.height = 20
  self.speed = 200
  self.xVel = - self.speed
  self.yVel = 0
end

function ball:update(dt)
  self:move(dt)
  self:collide()
end

function ball:move(dt)
  self.x = self.x + self.xVel * dt
  self.y = self.y + self.yVel * dt
end

-- how he handled collision is actually better than random movement, I think we can improve on it
function ball:collide()
  
  if checkCollision(self, player) then
    self.xVel = self.speed
    local middleBall = self.y + self.height/2
    local middlePlayer = player.y + player.height/2
    local collisionPosition = middleBall - middlePlayer
    self.yVel = collisionPosition*5
  end
  
  if checkCollision(self, AI) then
    self.xVel = - self.speed
    local middleBall = self.y + self.height/2
    local middleAI = AI.y + AI.height/2
    local collisionPosition = middleBall - middleAI
    self.yVel = collisionPosition*5
  end
  
  --[[if self.x < 0 then
    self.x = 0
    self.xVel = - self.xVel
  elseif self.x > windowWidth then
    self.x = windowWidth
    self.xVel = - self.xVel
  else]]
  if self.y < 0 then
    self.y = 0
    self.yVel = - self.yVel
  elseif self.y > windowHeight then
    self.y = windowHeight
    self.yVel = - self.yVel
  end
  
  if self.x < 0 then
    self.x = windowWidth/2 - self.width
    self.y = windowHeight/2 - self.height
    self.yVel = 0
    self.xVel = self.speed
  elseif self.x > windowWidth then
    self.x = windowWidth/2 - self.width
    self.y = windowHeight/2 - self.height
    self.yVel = 0
    self.xVel = - self.speed
  end
end

function ball:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height) 
end