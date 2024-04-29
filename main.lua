io.stdout:setvbuf('no') --for console message
love.graphics.setDefaultFilter("nearest")

local scenesManager = require("scenes.scenesManager")
scenesManager.addScenes("menu", "scenes.sceneMenu")
scenesManager.addScenes("gameplay", "scenes.sceneGameplay")
scenesManager.addScenes("paused", "scenes.scenePause")
scenesManager.changeScene('menu')
-- scenesManager.changeScene('gameplay')


function love.load()
end

function love.update(dt)
    scenesManager.update(dt)
end

function love.draw()
    scenesManager.draw()
end

function love.keypressed(key)
    scenesManager.keypressed(key)
end
