local sceneGameplay = {}

local scenesManager = require('scenes.scenesManager')

local player = require('modules.player')
local ennemi = require('modules.ennemi')

function sceneGameplay.load()
    player.load()
    ennemi.load()
end

function sceneGameplay.update(dt)
    player.update(dt)
    ennemi.update(dt)
end

function sceneGameplay.draw()
    love.graphics.print('la scene gameplay')
    player.draw()
    ennemi.draw()
end

function sceneGameplay.keypressed(key)
    if key == "space" then
        scenesManager.changeScene('gameplay')
    end
end

return sceneGameplay
