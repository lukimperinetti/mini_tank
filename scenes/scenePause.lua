local sceneMenu = {}

local scenesManager = require('scenes.scenesManager')

-- Load a font and a background image
local font
-- local backgroundImage

function sceneMenu.load()
    font = love.graphics.newFont("src/fonts/PixelifySans-Medium.ttf", 40)
    -- backgroundImage = love.graphics.newImage("assets/yourBackgroundImage.png")
end

function sceneMenu.update(dt)
end

function sceneMenu.draw()
    -- Draw the background image
    -- love.graphics.draw(backgroundImage, 0, 0)

    -- Set the font and print the text in the center of the screen
    love.graphics.setFont(font)
    love.graphics.printf('Game paused press "P" to return in the game', 0,
        love.graphics.getHeight() / 2.5,
        love.graphics.getWidth(),
        'center')
end

function sceneMenu.keypressed(key)
    if key == "p" then
        scenesManager.changeScene('gameplay')
    end
    if key == "escape" then
        love.event.quit()
    end
end

return sceneMenu
