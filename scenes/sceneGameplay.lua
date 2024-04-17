local sceneGameplay = {}

local scenesManager = require('scenes.scenesManager')

local player = require('modules.player')

function sceneGameplay.load()
    player.load()
end

function sceneGameplay.update(dt)
    player.update(dt)
end

function sceneGameplay.draw()
    love.graphics.print('la scene gameplay')
    player.draw()
end

function sceneGameplay.keypressed(key)
    if key == "space" then
        scenesManager.changeScene('gameplay')
    end
end

return sceneGameplay
