-- the "__includes" bit here means we're going to inherit all of the methods
-- that BaseState has, so it will have empty versions of all StateMachine methods
-- even if we don't override them ourselves; handy to avoid superfluous code!
CompleteState = Class{__includes = BaseState}

function CompleteState:enter(time)
    print('entered complete state' .. time)
    self.time = time
end

function CompleteState:update(dt)
    -- confirm whichever option we have selected to change screens
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return')
        or love.keyboard.wasPressed('kpenter') then
        gSounds['confirm']:play()

        gStateMachine:change('start')
    end

    -- we no longer have this globally, so include here
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function CompleteState:render()
    -- title
    love.graphics.setFont(gFonts['titleFont'])
    love.graphics.printf("SUDOKU", 0, WINDOW_HEIGHT / 6,
        WINDOW_WIDTH, 'center')
    
    love.graphics.printf(string.format('time: %02d:%02d',math.floor(self.time / 60),math.floor(self.time % 60)), 0, WINDOW_HEIGHT / 4,
        WINDOW_WIDTH, 'center')
    
    love.graphics.setColor(gColors['highlighted'])
    love.graphics.printf("Main Menu", 0, WINDOW_HEIGHT / 3 * 2,
        WINDOW_WIDTH, 'center')
    love.graphics.printf("Quit", 0, WINDOW_HEIGHT / 3 * 4,
        WINDOW_WIDTH, 'center')
   
end

