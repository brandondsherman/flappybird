PipePair = Class{}

local GAP = 90

function PipePair:init(y)
    self.x = VIRTUAL_WIDTH
    self.y = y

    self.pipes = {
        ['top'] = Pipe('top', self.y),
        ['bot'] = Pipe('bot', self.y + PIPE_HEIGHT + GAP)
    }

    self.remove = false
end

function PipePair:update(dt)
    if self.x + PIPE_WIDTH < 0 then
        self.remove = true
    end
    self.x = self.x - PIPE_SPEED * dt
    self.pipes['top'].x = self.x
    self.pipes['bot'].x = self.x
    
end


function PipePair:draw()
    self.pipes['top']:draw()
    self.pipes['bot']:draw()
end