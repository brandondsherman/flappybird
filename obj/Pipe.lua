Pipe = Class{}

local PIPE_IMAGE = love.graphics.newImage("data/pipe.png")
local PIPE_SCROLL = -60


function Pipe:init(loc, y)
    self.x = VIRTUAL_WIDTH
    self.loc = loc
    self.y = y
    self.width = PIPE_IMAGE:getWidth()
end


function Pipe:update(dt)
    self.x = self.x + PIPE_SCROLL * dt
end


function Pipe:draw()
    love.graphics.draw(PIPE_IMAGE, self.x, 
        (self.loc == 'top' and self.y + PIPE_HEIGHT or self.y),
        0, 1, self.loc == 'top' and -1 or 1
    )
end