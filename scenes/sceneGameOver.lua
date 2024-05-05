local GameOver = {}

local scenesManager = require('scenes.scenesManager')
local player = require('modules.player')
local ennemi = require('modules.ennemi')

-- Load a font and a background image
local font
-- local backgroundImage

function GameOver.load()
    font = love.graphics.newFont("src/fonts/PixelifySans-Medium.ttf", 40)
    -- backgroundImage = love.graphics.newImage("assets/yourBackgroundImage.png")
end

function GameOver.update(dt)
end

function GameOver.draw()
    -- Draw the background image
    -- love.graphics.draw(backgroundImage, 0, 0)

    -- Set the font and print the text in the center of the screen
    love.graphics.setFont(font)
    if player and ennemi and player.score and ennemi.score and player.score > ennemi.score then
        love.graphics.printf('You Win! Your Score:  ' .. player.score, 0,
            love.graphics.getHeight() / 2.5,
            love.graphics.getWidth(),
            'center')
    else
        love.graphics.printf('You Lose !', 0,
            love.graphics.getHeight() / 2.5,
            love.graphics.getWidth(),
            'center')
    end
end

function GameOver.keypressed(key)
    if key == "return" then
        scenesManager.changeScene('gameplay')
    end
    if key == "escape" then
        love.event.quit()
    end
end

return GameOver
