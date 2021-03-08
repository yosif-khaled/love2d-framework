local class = require ( 'class' )
local Sprite = class:derive( 'Sprite' )
local Anim = class:derive( 'Animation' )

function Sprite:new(atlas, x, y, w, h)
  self.x = x
  self.y = y
  self.width = w
  self.height = h
  self.atlas = atlas
  self.animations = {}
  self.current_anim = ''
  self.quad = love.graphics.newQuad(0, 0, self.width, self.height, self.atlas:getDimensions())
end

function Sprite:add_animation(name, anim)
  self.animations[name] = anim
end

function Sprite:animate(anim_name)
  if self.current_anim ~= anim_name and self.animations[anim_name] ~= nill then
    self.animations[anim_name]:set(self.quad)
    self.current_anim = anim_name
  end
end


function Sprite:update(dt)
  if self.animations[anim_name] ~= nill then
    self.animations[anim_name]:update(dt, self.quad)
  end
end

function Sprite:draw()
  love.graphics.draw(self.atlas, self.quad, self.x, self.y, 0, 1, 1, self.width/2, self.height/2)
end

return Sprite