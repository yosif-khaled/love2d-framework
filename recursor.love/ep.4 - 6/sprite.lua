local class = require ( 'class' )
local Vector2 = require ( 'vector2' )
local Sprite = class:derive ( 'Sprite' )
local Anim = class:derive ( 'Animation' )

function Sprite:new(atlas, x, y, w, h, sx, sy, angle)
  self.pos = Vector2(x or 0, y or 0)
  self.scale = Vector2(sx or 1, sy or 1)
  self.w = w
  self.h = h
  self.angle = angle or 0
  self.atlas = atlas
  self.animations = {}
  self.current_anim = ''
  self.quad = love.graphics.newQuad(0, 0, w, h, atlas:getDimensions())
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
  if self.animations[self.current_anim] ~= nill then
    self.animations[self.current_anim]:update(dt, self.quad)
  end
end

function Sprite:draw()
  love.graphics.draw(self.atlas, self.quad, self.pos.x, self.pos.y, self.angle, self.scale.x, self.scale.y, self.w/2, self.h/2)
end

return Sprite