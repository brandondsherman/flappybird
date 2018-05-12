push = require  'libs/push'
Class = require 'libs/class'
require 'libs/StateMachine'

require 'obj/Bird'
require 'obj/Pipe'
require 'obj/PipePair'


require 'obj/BaseState'
require 'obj/PlayState'
require 'obj/TitleScreenState'
require 'obj/ScoreState'
require 'obj/CountdownState'



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
local GROUND_LOOPING_POINT = 514



JUMP_KEY = 'w'



function love.load()

    math.randomseed(os.time())
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    love.window.setTitle('Flappy Bird')

    smallFont = love.graphics.newFont('data/font.ttf', 8)
    mediumFont = love.graphics.newFont('data/flappy.ttf', 14)
    flappyFont = love.graphics.newFont('data/flappy.ttf', 28)
    hugeFont = love.graphics.newFont('data/flappy.ttf', 56)
    love.graphics.setFont(flappyFont)

    sounds = {
        ['jump'] = love.audio.newSource('data/jump.wav', 'static'),
        ['explosion'] = love.audio.newSource('data/explosion.wav', 'static'),
        ['hurt'] = love.audio.newSource('data/hurt.wav', 'static'),
        ['score'] = love.audio.newSource('data/score.wav', 'static'),

        -- https://freesound.org/people/xsgianni/sounds/388079/
        ['music'] = love.audio.newSource('data/marios_way.mp3', 'static')
    }

    sounds['music']:setLooping(true)
    sounds['music']:play()
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end,
        ['countdown'] = function() return CountdownState() end,
    }

    gStateMachine:change('title')

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
        % GROUND_LOOPING_POINT
    
    gStateMachine:update(dt)

    love.keyboard.keyPressed = {}
end

function love.draw()
    push:start()
    love.graphics.draw(background, -1 * backgroundScroll, 0)
    
    gStateMachine:draw()

    love.graphics.draw(ground, -1 * groundScroll, VIRTUAL_HEIGHT - 16)
    push:finish()
end