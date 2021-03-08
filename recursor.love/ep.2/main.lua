-- episode 2 and epsiode 3

local hero_atlas
local hero_sprite

local angle = 0

-- animation parameters
local fps = 14
local animation_timer = 1 / fps
local frame = 1
local num_frames = 6
local xoffset

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  hero_atlas = love.graphics.newImage('assets/hero.png')
  hero_sprite = love.graphics.newQuad(16, 32, 16, 16, hero_atlas:getDimensions())
end
  
function love.update(dt)
  --angle = angle + 27.5 * dt
  animation_timer = animation_timer - dt
  if animation_timer <= 0 then
    animation_timer = 1/ fps
    frame = frame + 1
    if frame > num_frames then frame = 1 end
    xoffset = 16 * frame
    hero_sprite:setViewport(xoffset, 32, 16, 16)
  end
end
  
function love.draw()
  --love.graphics.draw(hero_atlas, 25, 25, 0, 1)
  love.graphics.draw(hero_atlas, hero_sprite, love.graphics.getWidth()/2, love.graphics.getHeight()/2, math.rad(angle), 10, 10, 8, 8)
end