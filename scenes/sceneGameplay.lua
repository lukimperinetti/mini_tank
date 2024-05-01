local sceneGameplay = {}

local scenesManager = require('scenes.scenesManager')

local player = require('modules.player')
local ennemi = require('modules.ennemi')
local bgImage

function sceneGameplay.load()
    player.load()
    ennemi.load()

    bgImage = love.graphics.newImage('src/images/Grass_Sample.png')
    bgImageScaleX = 1240 / bgImage:getWidth()
    bgImageScaleY = 700 / bgImage:getHeight()
end

function sceneGameplay.update(dt)
    player.update(dt)
    ennemi.update(dt)
end

function sceneGameplay.draw()
    love.graphics.draw(bgImage, 0, 0, 0, bgImageScaleX, bgImageScaleY)
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
