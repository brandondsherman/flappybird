Bird = Class{}

local GRAVITY = 20
local JUMP_KEY = 'w'

function Bird:init()
    self.image = love.graphics.newImage('data/bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    
    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT  / 2 - (self.height / 2)
    self.dy = 0
end

function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt
    
    if love.keyboard.wasPressed(JUMP_KEY) then
        self.dy = -5 
    end

    self.y = self.y + self.dy

    
end

function Bird:draw()
    love.graphics.draw(self.image, self.x, self.y)
end