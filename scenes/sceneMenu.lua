local sceneMenu = {}

local scenesManager = require('scenes.scenesManager')


function sceneMenu.load()

end

function sceneMenu.update(dt)
end

function sceneMenu.draw()
    love.graphics.print('Press SPACE to play the game')
end

function sceneMenu.keypressed(key)
    if key == "space" then
        scenesManager.changeScene('gameplay')
    end
end

return sceneMenu
