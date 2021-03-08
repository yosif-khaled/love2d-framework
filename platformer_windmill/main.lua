local STI = require ( 'sti' )
require ( 'player' )

function love.load()
	-- loading the map and letting the computer know we are going to use box2d
	Map = STI('maps/level01.lua', {'box2d'})
	-- creating a physics world
	world = love.physics.newWorld(0,0)
	-- initializing box 2d physics this function takes one argument which is the world
	Map:box2d_init(world)
	-- preventing colliders from being drawn to the screen
	Map.layers.solid.visible = false
	-- calling the background image
	background = love.graphics.newImage('assets/background.png')
	Player:load()
end

function love.update(dt)
	-- to make things move we need to call world:update
	world:update(dt)
	Player:update(dt)

end

function love.draw()
	-- drawing the background - takes up to 10 arguments
	love.graphics.draw(background, 0, 0, nill, 5, 5)
	Map:draw(0,0,2,2)
	-- push and pop are used to keep 
	love.graphics.push()
	love.graphics.scale(2,2)
	Player:draw()
	love.graphics.pop()
end