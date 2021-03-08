-- episode 4 to ..
local Anim = require( 'Animation' )
local Sprite = require( 'Sprite' )

local hero_atlas

local angle = 0

-- animation parameters
local fps = 14
local animation_timer = 1 / fps
local frame = 1
local num_frames = 6
local xoffset

local spr
local walk = Anim(16, 32, 16, 16, 6, 6, 12)

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  hero_atlas = love.graphics.newImage('assets/hero.png')
  --hero_sprite = love.graphics.newQuad(16, 32, 16, 16, hero_atlas:getDimensions())
  spr = Sprite(hero_atlas, 16, 16, 100, 100)
  spr:add_animation('walk', walk)
  spr:animate('walk')
  
end
  
function love.update(dt)
  --angle = angle + 27.5 * dt
  --[[
  animation_timer = animation_timer - dt
  if animation_timer <= 0 then
    animation_timer = 1/ fps
    frame = frame + 1
    if frame > num_frames then frame = 1 end
    xoffset = 16 * frame
    hero_sprite:setViewport(xoffset, 32, 16, 16)
  end]]
  spr:update(dt)
end
  
function love.draw()
  love.graphics.clear(45/255, 85/255, 1)
  --love.graphics.draw(hero_atlas, 25, 25, 0, 1)
  --love.graphics.draw(hero_atlas, hero_sprite, love.graphics.getWidth()/2, love.graphics.getHeight()/2, math.rad(angle), 10, 10, 8, 8)
  spr:draw()
end