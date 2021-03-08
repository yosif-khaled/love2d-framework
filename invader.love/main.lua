love.graphics.setDefaultFilter('nearest', 'nearest')
enemy = {}
enemies_controller = {}
enemies_controller.enemies = {}
enemies_controller.image = love.graphics.newImage('assets/enemy01.png')

function love.load()
  player = {}
  player.x = 0
  player. y = 110
  player.image = love.graphics.newImage('assets/playerSkin01.png')
  --player.fire_sound = love.audio.newSource()-- add sound
  player.bullets = {}
  player.cooldown = 20
  player.speed = 2
  player.fire = function()
    
    if player.cooldown <= 0 then
      player.cooldown = 20
      bullet = {}
      bullet.x = player.x + 5
      bullet.y = player.y - 1
      table.insert(player.bullets, bullet)
      --love.audio.play(player.fire_sound)
    end
  end

  enemies_controller:spawnEnemy(0, 0)
  enemies_controller:spawnEnemy(100, 0)

end

function enemies_controller:spawnEnemy(x, y)
  enemy = {}
  enemy.x = x
  enemy.y = y
  enemy.bullets = {}
  enemy.cooldown = 20
  enemy.speed = 2
  table.insert(self.enemies, enemy)
end

function enemy:fire()
  if self.cooldown <= 0 then
    self.cooldown = 20
    bullet = {}
    bullet.x = self.x + 10
    bullet.y = self.y
    table.insert(self.bullets, bullet)
  end
end

function love.update(dt)
  player.cooldown = player.cooldown - 1
  if love.keyboard.isDown('right') then
    player.x = player.x + player.speed
  elseif love.keyboard.isDown('left') then
    player.x = player.x - player.speed
  end
  
  if love.keyboard.isDown('space') then
    player.fire()
  end
  
  for _, e in ipairs(enemies_controller.enemies) do
    e.y = e.y + 1
  end
  
  for i, b in ipairs(player.bullets) do
    if b.y < -10 then
      table.remove(player.bullets, i)
    end
    b.y = b.y - 1
  end
end

function love.draw()
  love.graphics.scale(5)
  love.graphics.draw(player.image, player.x, player.y, 0, 1)

love.graphics.setColor(1, 1, 1)
  for _, e in ipairs(enemies_controller.enemies) do
    love.graphics.draw(enemies_controller.image, e.x, e.y, 0, 1)
  end
  
  for _, b in ipairs(player.bullets) do
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle('fill', b.x, b.y, 1, 1)
  end
end