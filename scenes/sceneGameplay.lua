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
    love.graphics.print('Your Score:  ' .. player.score, 10, 10)
    player.draw()
    ennemi.draw()
end

function sceneGameplay.keypressed(key)
    if key == "p" then
        scenesManager.changeScene('paused')
    end
    if key == "escape" then
        love.event.quit()
    end
end

return sceneGameplay
