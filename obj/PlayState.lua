PlayState = Class{__includes = BaseState}

PIPE_HEIGHT = 288
PIPE_WIDTH = 70
PIPE_SPEED = 60

BIRD_WIDTH = 38
BIRD_HEIGHT = 24


function PlayState:init()
    self.bird = Bird()
    self.pipePairs = {}
    self.spawnTimer = 0

    self.lastY = -PIPE_HEIGHT + math.random(80) + 20
end

function PlayState:update(dt)
    self.spawnTimer = self.spawnTimer + dt

    
    if self.spawnTimer > 2 then
        local y = math.max(-PIPE_HEIGHT + 10,
                    math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
        self.lastY = y
        
        table.insert(self.pipePairs, PipePair(y))
        self.spawnTimer = 0
    end

    self.bird:update(dt)

    for k, pair in pairs(self.pipePairs) do 
        pair:update(dt)
        for _, pipe in pairs(pair.pipes) do
            if self.bird:collides(pipe) then
                gStateMachine:change('title')
            end
        end
    end

    for k, pair in pairs(self.pipePairs) do
        if pair.remove then
            table.remove(self.pipePairs, k)
        end
    end

end

function PlayState:draw()
    self.bird:draw()
    for k, pair in pairs(self.pipePairs) do
        pair:draw()
    end
end

--function BaseState:enter() end
--function BaseState:exit() end