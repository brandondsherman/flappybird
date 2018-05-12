push = require  'libs/push'

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

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    love.window.setTitle('Flappy Bird')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

end

function love.resize(w, h)
    push:resize(w,h)
end


function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
        % BACKGROUND_LOOPING_POINT

    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
        % VIRTUAL_WIDTH
end

function love.draw()
    push:start()
    love.graphics.draw(background, -1 * backgroundScroll, 0)
    love.graphics.draw(ground, -1 * groundScroll, VIRTUAL_HEIGHT - 16)

    push:finish()
end