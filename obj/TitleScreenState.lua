TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed(JUMP_KEY) then
        gStateMachine:change('play')
    end
end


function TitleScreenState:draw()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Flappy Bird', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press W', 0, 100, VIRTUAL_WIDTH, 'center')
end

--function BaseState:enter() end
--function BaseState:exit() end