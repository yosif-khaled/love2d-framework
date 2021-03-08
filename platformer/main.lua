
function love.load()

	love.window.setMode(1000, 768)

	-- importing the anim8 libraries
	anim8 = require 'libraries/anim8/anim8'

	sti = require 'libraries/Simple-Tiled-Implementation/sti'

	-- creating a camera object
	cameraFile = require 'libraries/hump/camera'
	cam = cameraFile()

	-- loading music
	sounds = {}
	sounds.jump = love.audio.newSource('sounds/jump.wav', 'static')
	sounds.music = love.audio.newSource('sounds/music.mp3', 'static')
	sounds.music:play()
	sounds.music:setLooping(true)
	sounds.music:setVolume(0.5)

	-- importing the sprite sheet
	sprites = {}
	sprites.playerSheet = love.graphics.newImage('assets/playerSheet.png')
	sprites.enemySheet = love.graphics.newImage('assets/enemySheet.png')
	sprites.background = love.graphics.newImage('assets/background.png')

	local grid = anim8.newGrid(math.floor(sprites.playerSheet:getWidth()/15), math.floor(sprites.playerSheet:getHeight()/3), sprites.playerSheet:getWidth(), sprites.playerSheet:getHeight())

	local enemyGrid = anim8.newGrid(100, 70, sprites.enemySheet:getWidth(), sprites.enemySheet:getHeight())

	animations = {}

	animations.idle = anim8.newAnimation(grid('1-15', 1), 0.05)
	animations.jump = anim8.newAnimation(grid('1-7', 2), 0.05)
	animations.run = anim8.newAnimation(grid('1-15', 3), 0.05)
	animations.enemy = anim8.newAnimation(enemyGrid('1-2', 1), 0.03)

	-- importing the windfield libraries
	wf = require 'libraries/windfield/windfield'
	-- creating a world for physics to exist in
	world = wf.newWorld(0, 800, false) -- where the value of x and y are the direction of gravity
	world:setQueryDebugDrawing(true)

	world:addCollisionClass('Platform')
	world:addCollisionClass('Player' --[[, {ignores = {'Platform'}}]])
	world:addCollisionClass('Danger') -- stopping rotating motion

	require( 'player' )

	require( 'enemy' )

	dangerZone = world:newRectangleCollider(-500, 800, 5000, 50, {collision_class = "Danger"})
	dangerZone:setType('static')

	platforms = {}

	flagX = 0
	flagY = 0

	-- serializing data

	require( '/libraries/show' )

	saveData = {}
	saveData.currentLevel = 'level01'

	if love.filesystem.getInfo('data.lua') then
		local data = love.filesystem.load('data.lua')
		data()
	end

	loadMap(saveData.currentLevel)

	--spawnEnemy(800, 180)

end --love.load

function love.update(dt)

	world:update(dt)
	gameMap:update(dt)
	playerUpdate(dt)
	updateEnemies(dt)

	
	local px, py = player:getPosition()
	cam:lookAt(px, love.graphics.getHeight()/2)

	local colliders = world:queryCircleArea(flagX, flagY, 10, {'Player'})
	if #colliders > 0 then 
		if saveData.currentLevel == 'level01' then
			loadMap('level02')
		elseif saveData.currentLevel == 'level02' then
			loadMap('level01')
		end
	end

end --love.update

function love.draw()
	love.graphics.draw(sprites.background)
	cam:attach()
		gameMap:drawLayer(gameMap.layers['Tile Layer 1'])
		--world:draw()
		drawPlayer()
		drawEnemies()
	cam:detach()

end --love.draw

function spawnPlatform(x, y, width, height)
	local platform = world:newRectangleCollider(x, y, width, height, {collision_class = 'Platform'}) -- convert to local
	platform:setType('static') -- to change collider type from the default(dynamic) to static or kinematic
	table.insert(platforms, platform)
end

function destroyAll()
	local i = #platforms
	while i > -1 do
		if platforms[i] ~= nil then
			platforms[i]:destroy()
		end
		table.remove(platforms, i)
		i = i - 1
	end

	local e = #enemies
	while e > -1 do
		if enemies[e] ~= nil then
			enemies[e]:destroy()
		end
		table.remove(enemies, e)
		e = e - 1
	end
end

function love.keypressed(key)
	if key == 'up' and player.grounded then
		player:applyLinearImpulse(0, -3500) -- x & y values represent the magnitude of the jump relevant to gravity
		sounds.jump:play()
	end -- end of if function
	if key == 'r' then
		loadMap('level01')
	end
end -- of love.keypressed function

function love.mousepressed(x, y, button)
	if button == 1 then
		local colliders = world:queryCircleArea(x, y, 200, {'Platform', 'Danger'})
		for i, c in ipairs(colliders) do
			c:destroy()
		end
	end
end -- of love.mousepressed funtion

function loadMap(mapName)
	saveData.currentLevel = mapName
	love.filesystem.write('data.lua', table.show(saveData, 'saveData'))
	destroyAll()
	player:setPosition(playerStartX, playerStartY)
	gameMap = sti('maps/'..mapName..'.lua')
	for i, obj in pairs(gameMap.layers['Platforms'].objects) do
		spawnPlatform(obj.x, obj.y, obj.width, obj.height)
	end
	for i, obj in pairs(gameMap.layers['Enemies'].objects) do
		spawnEnemy(obj.x, obj.y)
	end

	for i, obj in pairs(gameMap.layers['Flag'].objects) do
		flagX = obj.x
		flagY = obj.y
	end

end -- of load map function