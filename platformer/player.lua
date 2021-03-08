playerStartX = 360
playerStartY = 100

-- creating a collider stored in a player object
player = world:newRectangleCollider(playerStartX, playerStartY, 30, 110, {collision_class = "Player"})
player:setFixedRotation(true)
player.speed = 240 -- works because a collider is a table
player.animation = animations.idle
player.isMoving = false
player.direction = 1
player.grounded = true -- I would use isJumping
	

function playerUpdate(dt)
  if player.body then

		local colliders = world:queryRectangleArea(player:getX()-15, player:getY()+55, 30, 2, {'Platform'})
		if #colliders > 0 then
			player.grounded = true
		else
			player.grounded = false
		end

		player.isMoving = false
		-- grab the position of the player
		local playerX, playerY = player:getPosition()
		if love.keyboard.isDown('right') then
			player:setX(playerX + player.speed * dt)
			player.isMoving = true
			player.direction = 1
		end
		if love.keyboard.isDown('left') then
			player:setX(playerX - player.speed * dt)
			player.isMoving = true
			player.direction = -1
		end

		-- death when touching dangerZone
		if player:enter('Danger') then
			player:setPosition(playerStartX, playerStartY)
		end
	end -- if you remove this if statement you will get an error because body is still moving and it is supposed to be destroyed
	if player.grounded then
		if player.isMoving then
			player.animation = animations.run
		else
			player.animation = animations.idle
		end
	else
		player.animation = animations.jump
	end
	player.animation:update(dt)
end


function drawPlayer()

	local px, py = player:getPosition()
	player.animation:draw(sprites.playerSheet, px, py, nil, 0.5 * player.direction, 0.5, math.floor(sprites.playerSheet:getWidth()/15)/5, math.floor(sprites.playerSheet:getHeight()/3)/2 + 20)
  
end