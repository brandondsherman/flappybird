ScoreState = Class{__includes = BaseState}



function ScoreState:enter(par)
    self.score = par.score
end


function ScoreState:update(dt)
    if love.keyboard.wasPressed(JUMP_KEY) then
        gStateMachine:change('countdown')
    end
end

function ScoreState:draw()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('U DED', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press '.. JUMP_KEY .. ' to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')

end