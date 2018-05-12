push = require  'libs/push'
Class = require 'libs/class'
require 'obj/Bird'
require 'obj/Pipe'
require 'obj/PipePair'


WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288
local background = love.graphics.newImage('data/background.png')
local backgroundScroll = 0
local BACKGROUND_SCROLL_SPEED = 30
local BACKGROUND_LOOPING_POINT = 413

local ground = love.graphics.newImage('data/ground.png') 
local groundScroll = 0
local GROUND_SCROLL_SPEED = 60
--local GROUND_LOOPING_POINT = VIRTUAL_WIDTH

local bird = Bird()

local pipePairs = {}

local spawnTimer = 0

local lastY = -PIPE_HEIGHT + math.random(80) + 20

function love.load()

    math.randomseed(os.time())
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    love.window.setTitle('Flappy Bird')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    love.keyboard.keyPressed = {}

end

function love.resize(w, h)
    push:resize(w,h)
end


function love.keypressed(key)
    love.keyboard.keyPressed[key] = true
    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keyPressed[key] then
        return true
    else
        return false
    end
end

function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
        % BACKGROUND_LOOPING_POINT

    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
        % VIRTUAL_WIDTH

    spawnTimer = spawnTimer + dt

    if spawnTimer > 2 then
        local y = math.max(-PIPE_HEIGHT + 10,
                    math.min(lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
        lastY = y
        
        table.insert(pipePairs, PipePair(y))
        spawnTimer = 0
    end
    
    
    bird:update(dt)

    for k, pair in pairs(pipePairs) do 
        pair:update(dt)
    end

    for k, pair in pairs(pipePairs) do
        if if pair.remove then
            table.remove(pipePairs, k)
        end
    end

    love.keyboard.keyPressed = {}

end

function love.draw()
    push:start()
    love.graphics.draw(background, -1 * backgroundScroll, 0)
    for k, pair in pairs(pipePairs) do
        pair:draw()
    end
    love.graphics.draw(ground, -1 * groundScroll, VIRTUAL_HEIGHT - 16)

    bird:draw()

    push:finish()
end