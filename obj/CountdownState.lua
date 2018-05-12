CountdownState = Class{__includes = BaseState}

COUNTDOWN_TIME = .33

function CountdownState:init()
    self.count = 3
    self.timer = 0
end



function CountdownState:update(dt)
    self.timer = self.timer + dt

    if self.timer > COUNTDOWN_TIME then
        self.count = self.count - 1
        self.timer = self.timer % COUNTDOWN_TIME

        if self.count == 0 then
            gStateMachine:change('play')
        end
    end
end

function CountdownState:draw()
    love.graphics.setFont(hugeFont)
    love.graphics.printf(tostring(self.count), 0, 120, VIRTUAL_WIDTH, 'center')
end