io.stdout:setvbuf('no') --for console message
love.graphics.setDefaultFilter("nearest")

local scenesManager = require("scenes.scenesManager")
scenesManager.addScenes("menu", "scenes.sceneMenu")
scenesManager.addScenes("gameplay", "scenes.sceneGameplay")
scenesManager.changeScene('menu')


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
